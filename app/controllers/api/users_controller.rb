module Api
  class UsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_user

    before_action :check_password, only: [:create], if: -> { @user.present? and params[:provider] == "email"}
    before_action :check_provider_user_id, only: [:create], if: -> { @user.present? and params[:provider] == "facebook"}



    def create
      if params[:provider_token].nil?
        render json: {message: "provider_token manca"}, status: :unauthorized
        return
      end

      if params[:provider] == "facebook"
        user = User.create(user_params.merge!(provider_user_id: @facebook_user_id))
        render json: user, status: :created, location: api_user_path(user)
      else
        user = User.create(user_params.merge!(password: params[:provider_token]))
        if user.save
          render json: user, status: :created, location: api_user_path(user)
        else
          render json: user, status: :orized if user_params[:password].nil?
        end
      end
    end


    def reset_password_auto
      if @user.present?
        temp_code = TemporaryCode.create({user_id: @user.id})
        if temp_code.save
          ExampleMailer.welcome_email(@user, temp_code).deliver_later
          render json: {message: "Abbiamo mandato una mail con la nuova password."}, status: :ok
        else
          render json: {message: "Non e'stata possbile creare una password temporanea."}, status: :unauthorized
        end
      else
        render json: {message: "Email non trovata"}, status: :not_found
      end
    end

    def reset_password
      if  @user.present? and params[:provider_token].present?
        @user.update_attributes({password: params[:provider_token] })
        render json: {message: "Password aggiornata"}, status: :ok
      else
        render json: {message: "Email non trovata"}, status: :not_found
      end
    end

    def temporary_login
      if @user.present?
        temp_code = TemporaryCode.where(user_id: @user.id, code: params[:provider_token]).where("validity >= ? ", Time.now.utc).first
        if temp_code.present?
          TemporaryCode.destroy_all(user_id: @user.id)
          render json: nil, status: :ok
        else
          render json: {message: "Codice scaduto."}, status: :unauthorized
        end 
      else
        render json: {message: "Email non trovata"}, status: :not_found
      end
    end

    private

    def set_user
      @user = User.find_by(email: params[:email])
    end

    def user_params
      params.permit(:email)
    end

    def check_provider_user_id
      if @user.provider_user_id.nil?
        @user.update_attributes({provider_user_id: @facebook_user_id})
      end
      render json: @user, status: :ok, location: api_user_path(@user)
    end

    def check_password
      if params[:provider_token].nil?
        render json: {message: "provider_token manca"}, status: :unauthorized
        return
      end
      if @user.password.nil?
        @user.update_attributes({:password => params[:provider_token]})
        render json: @user, status: :ok, location: api_user_path(@user)
      elsif @user.password == params[:provider_token]
        render json: @user, status: :ok, location: api_user_path(@user)
      else
        render json: {message: "Utente gia' registrato"}, status: :unauthorized
      end
    end

  end
end
