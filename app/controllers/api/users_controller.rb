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
      @user = User.find_by(email: params[:email])
      if @user.present?
        @user.update_attributes({password: (0...6).map { ('A'..'Z').to_a[rand(26)] }.join})
        ExampleMailer.welcome_email(@user).deliver_later
        render json: {message: "Abbiamo mandato una mail con la nuova password!"}, status: :ok
      else
        render json: {message: "Email non trovata"}, status: :not_found
      end
    end

    def reset_password
      if  @user.present? and params[:provider_token].present?
        @user.update_attributes({password: params[:provider_token] })
        render nothing: true
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
