module Backoffice
  class PathsController < AuthenticatedController
    before_action :set_path, only: [:show, :edit, :update, :destroy]

    def index
      @paths = Path.all
    end

    def new
      @path = Path.new
    end

    def create
      @path = Path.new(path_params)

      if @path.save
        redirect_to [:backoffice, @path], notice: 'Path was successfully created.'
      else
        render :new
      end
    end

    def update
      if @path.update(path_params)
        redirect_to [:backoffice, @path], notice: 'Path was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @path.destroy
      redirect_to backoffice_paths_url, notice: 'Path was successfully destroyed.'
    end

    private

    def set_path
      @path = Path.find(params[:id])
    end

    def path_params
      params.require(:path).permit(:title, :description, :image_id)
    end
  end
end
