module Backoffice
  class UsersController < AuthenticatedController
    def index
      @users = User.select(:email).uniq 
    end
  end
end
