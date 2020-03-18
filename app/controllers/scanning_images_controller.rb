class ScanningImagesController < ApplicationController

  def show
    @scanned_image = ScanningImage.includes(:scanned_cells).with_attached_png_image.find params[:id]
  end

  def processing
    images = ScanningImage.where.not(process_status: :complete).order(start_processing_at: :asc)
    render json: images
  end

end
