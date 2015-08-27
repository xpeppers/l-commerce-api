module Api
	class UsersController < ApplicationController
		def create
			user = User.new(email: params[:email], password: params[:password])
			if user.save
				render json: user, status: :created, location: api_user_path(user) 
			end	
		end
	end
end 