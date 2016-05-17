module Api
  class UsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_user
    before_action :update_fb_user_id, only: [:create], unless: -> { @user.nil? }
    before_action :update_password, only: [:email] , unless: -> { @user.nil? }

    def create
      user = User.create(user_params.merge!(provider_user_id: @facebook_user_id))
      render json: user, status: :created, location: api_user_path(user)
    end

    def email
      user = User.create(user_params)
      if user.save
        render json: user, status: :created, location: api_user_path(user)
      else
        render json: user, status: :unauthorized if user_params[:password].nil?
      end
    end

    def reset_password_auto
      if @user.present?
        @user.update_attributes({password: (0...6).map { ('A'..'Z').to_a[rand(26)] }.join})
        ExampleMailer.welcome_email(@user).deliver_later
        render nothing: true
      else
        render json: {message: "Email not found"}, status: :unauthorized
      end
    end

    def reset_password
      if  @user.present? and @user.password == params[:current_password] and params[:updated_password].present?
        @user.update_attributes({password: params[:updated_password] })
        render nothing: true
      else
        render json: {message: "Email not found"}, status: :unauthorized
      end
    end

    private

    def set_user
      @user = User.find_by(email: params[:email])
    end

    def user_params
      params.permit(:email, :password)
    end

    def update_fb_user_id
      if @user.provider_user_id.nil?
        @user.update_attributes({provider_user_id: @facebook_user_id})
      end
      render json: @user, status: :ok, location: api_user_path(@user)
    end

    def update_password
      if @user.password.nil?
        @user.update_attributes(user_params)
        render json: @user, status: :ok, location: api_user_path(@user)
      end
    end

  end
end
