module Backoffice
  class UsersController < AuthenticatedController
    def index
      @users = User.all.distinct
    end
  end
end
