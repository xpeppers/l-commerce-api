module Backoffice
  class ImagesController < AuthenticatedController

    def create
      @image = Image.new(image_params)
      @image.save
      render json: @image, status: :created
    end

    private

    def image_params
      params.require(:image).permit(:resource)
    end
  end
end
