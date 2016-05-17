module Api
  class UsersController < ApplicationController

    include AuthorizeFacebookUser

    before_action :set_user
    before_action :update_fb_user_id, only: [:create], unless: -> { @user.nil? }
    before_action :update_user_pass, only: [:email] , unless: -> { @user.nil? }

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

    def reset_password_link
        ExampleMailer.welcome_email(@user).deliver_later
        render nothing: true
    end

    def reset_password
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
          render json: @user, status: :ok, location: api_user_path(@user)
      end
    end

    def update_user_pass
        if @user.password.nil?
          @user.update_attributes(user_params)
          render json: @user, status: :ok, location: api_user_path(@user)
        end
    end

  end
end
