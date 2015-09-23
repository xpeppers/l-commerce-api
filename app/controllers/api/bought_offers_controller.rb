module Api
  class BoughtOffersController < AuthenticatedUserController

    def index
      render json: @authenticated_user.bought_offers
    end

  end
end
