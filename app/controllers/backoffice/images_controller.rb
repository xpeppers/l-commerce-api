module Backoffice
  class ImagesController < AuthenticatedController

    def create
      @image = Image.new(image_params)
      @image.save
      render json: @image, status: :created
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      head :no_content
    end

    private

    def image_params
      params.require(:image).permit(:resource)
    end
  end
end
