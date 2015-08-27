require 'rails_helper'

describe Api::UsersController, type: :controller do

	describe 'POST #create' do
		it 'creates a new user' do
			expect{
				post :create, email: 'email@address.com', password: 'email@address.com'
			}.to change(User, :count).by(1)
		end
	end

end
