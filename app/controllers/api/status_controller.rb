class Api::StatusController < ApplicationController
  def index
    render json: { version: '1.0.0', timestamp: Time.now }
  end
end
