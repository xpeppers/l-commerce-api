module Api
  class StagesController < ApplicationController

    def index
      render json: Stage.where(path_id: params[:path_id]), each_serializer: StageListSerializer
    end

    def show
      render json: Stage.find(params[:id])
    end

  end
end
