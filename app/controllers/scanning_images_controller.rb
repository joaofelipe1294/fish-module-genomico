class ScanningImagesController < ApplicationController

  def show
    @scanned_image = ScanningImage.includes(:scanned_cells).with_attached_png_image.find params[:id]
  end

  def processing
    images = ScanningImage.where.not(process_status: :complete).order(start_processing_at: :asc)
    images = images.map do |image|
      {
        id: image.id,
        start_processing_at: image.start_processing_at.strftime("%-d/%-m/%y: %H:%M:%S"),
        status: image.process_status
      }
    end
    render json: images
  end

  def complete
    @scanning_images = ScanningImage.complete.order(created_at: :desc)
  end

  def processing_progress
  end

end
