class ScanningImagesController < ApplicationController

  def index
    scanning_images = ScanningImage.complete
    if params[:status] == "pending"
      scanning_images = scanning_images.pending
    else
      scanning_images = scanning_images.analyzed
    end
    @scanning_images = scanning_images.order(created_at: :desc)
  end

  def show
    @scanned_cells = ScannedCell.where(scanning_image_id: params[:id]).order(:id).page params[:page]
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

  def processing_progress
  end

  def change_status_to_analyzed
    @scanning_image = ScanningImage.find params[:id]
    @scanning_image.update analysis_status: :analyzed
    flash[:success] = I18n.t :scanning_image_analyzed
    redirect_to @scanning_image
  end

  def analyzed
    @scanning_images = ScanningImage.analyzed.order(updated_at: :desc)
  end

end
