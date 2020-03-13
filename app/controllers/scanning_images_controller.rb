class ScanningImagesController < ApplicationController

  def show
    @scanned_image = ScanningImage.includes(:scanned_cells).find params[:id]
  end

end
