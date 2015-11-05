module Api
  class PathsController < ApplicationController

    def index
      render json: Path.all, each_serializer: PathListSerializer
    end

    def show
      render json: Path.find(params[:id])
    end

  end
end
