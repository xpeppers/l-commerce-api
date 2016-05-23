module Api
  class UsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_user

    before_action :update_empty_password, if: -> { not @user.nil? and params[:provider] == "email"}
    before_action :update_fb_empty_user_id, if: -> { not @user.nil? and params[:provider] == "facebook"}



    def create

      if !@user.nil?
        render json: @user, status: :ok, location: api_user_path(@user)
        return
      end

      if user_params[:provider] == "facebook"
        user = User.create(user_params.merge!(provider_user_id: @facebook_user_id))
        render json: user, status: :created, location: api_user_path(user)
      else
        user = User.create(user_params.merge!(password: params[:provider_token]))
        if user.save
          render json: user, status: :created, location: api_user_path(user)
        else
          render json: user, status: :unauthorized if user_params[:password].nil?
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
        render json: {message: "Email non trovato"}, status: :not_found
      end
    end

    def reset_password
      if  @user.present? and @user.password == params[:current_password] and params[:updated_password].present?
        @user.update_attributes({password: params[:updated_password] })
        render nothing: true
      else
        render json: {message: "Email non trovato"}, status: :not_found
      end
    end

    private

    def set_user
      if params[:provider] == "facebook"
        @user = User.find_by(email: params[:email], provider_user_id: @facebook_user_id)
      elsif params[:provider] == "email"
        @user = User.find_by(email: params[:email], password: params[:provider_token])
      end
    end

    def user_params
      params.permit(:email)
    end

    def update_fb_empty_user_id
      if @user.provider_user_id.nil?
        @user.update_attributes({provider_user_id: @facebook_user_id})
      end
      render json: @user, status: :ok, location: api_user_path(@user)
    end

    def update_empty_password
      if @user.password.nil?
        @user.update_attributes(user_params)
        render json: @user, status: :ok, location: api_user_path(@user)
      end
    end

  end
end
