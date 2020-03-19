class ScanningsController < ApplicationController
  before_action :set_scanning, only: [:show, :cells]

  def index
  end

  def show
  end

  def new
    @scanning = Scanning.new(fish_slice_id: params[:slice_id])
  end

  def create
    @scanning = Scanning.new scanning_params
    if @scanning.save
      flash[:success] = I18n.t :new_scanning_success
      redirect_to processing_progress_path
    else
      render :new
    end
  end

  def cells
  end

  private

    def scanning_params
      params.require(:scanning).permit(
        :responsible_id,
        :responsible_login,
        :date,
        :fish_slice_id,
        images: []
      )
    end

    def set_scanning
      @scanning = Scanning.includes(:scanning_images).find params[:id]
    end

end
