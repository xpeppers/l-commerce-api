module Api
	class UsersController < ApplicationController
		def create
			User.create
		end
	end
end 
