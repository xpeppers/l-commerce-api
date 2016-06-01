module Backoffice
  class UsersController < AuthenticatedController
    def index
      @users = User.select(:email, :created_at).uniq.order("created_at desc")
    end
  end
end
