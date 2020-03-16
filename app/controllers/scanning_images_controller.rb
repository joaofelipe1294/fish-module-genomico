class ScanningImagesController < ApplicationController

  def show
    @scanned_image = ScanningImage.includes(:scanned_cells).with_attached_png_image.find params[:id]
  end

end
