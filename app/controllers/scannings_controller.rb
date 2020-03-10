class ScanningsController < ApplicationController

  def index
  end

  def new
    @scanning = Scanning.new(fish_slice_id: params[:slice_id])
  end

  def create
    @scanning = Scanning.new scanning_params
    if @scanning.save
      flash[:success] = I18n.t :new_scanning_success
      redirect_to scannings_path
    else
      render :new
    end
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

end
