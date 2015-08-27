require 'rails_helper'

describe Api::UsersController, type: :controller do

	describe 'POST #create' do
		before do
			post :create, email: 'email@address.com', password: 'email@address.com'
		end

		it { should respond_with(:success) }
	end

end
