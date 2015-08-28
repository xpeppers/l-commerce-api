require 'rails_helper'

describe Api::StatusController, type: :controller do

  describe 'GET #index' do

    before do
      get :index
    end

    it 'responds with status success' do
      respond_with(:success)
    end

    it 'contains api version and timestamp' do
      expected_json = %({
        "version": "1.0.0"
      })

      expect(response.body).to be_json_eql(expected_json).excluding('timestamp')
    end

  end
end
