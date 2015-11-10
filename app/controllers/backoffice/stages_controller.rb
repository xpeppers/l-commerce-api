module Backoffice
  class StagesController < AuthenticatedController
    before_action :set_stage, only: [:show, :edit, :update, :destroy]

    def new
      @stage = Stage.new(path_id: params[:path_id])
    end

    def create
      @stage = Stage.new(stage_params)
      puts stage_params
      if @stage.save
        redirect_to [:backoffice, @stage.path, @stage], notice: 'Stage was successfully created.'
      else
        render :new
      end
    end

    def update
      if @stage.update(stage_params)
        redirect_to [:backoffice, @stage.path, @stage], notice: 'Stage was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @stage.destroy
      redirect_to backoffice_path_url(params[:path_id]), notice: 'Stage was successfully destroyed.'
    end

    private

    def set_stage
      @stage = Stage.find(params[:id])
    end

    def stage_params
      params.require(:stage).permit(:title, :description, :image_id, :merchant_id, :path_id)
    end
  end
end
