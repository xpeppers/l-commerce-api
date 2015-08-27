require 'rails_helper'

describe Api::UsersController, type: :controller do

	describe 'POST #create' do
		it 'creates a new user' do
			expect{
				post :create, email: 'email@address.com', password: 'email@address.com'
			}.to change(User, :count).by(1)
		end

		it 'responds with new user details' do
			post :create, email: 'email@address.com', password: 'email@address.com'
			
			expect(json).to eq({'email' => 'email@address.com'})
		end
	end

end
