module Api
  class BoughtOffersController < AuthenticatedUserController

    def index
      render json: @authenticated_user.bought_offers
    end

    def show
      render json: nil, status: :not_found
    end
  end
end
