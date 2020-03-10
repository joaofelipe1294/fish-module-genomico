class ScanningsController < ApplicationController

  def index
  end

  def new
    @scanning = Scanning.new(fish_slice_id: params[:slice_id])
  end

end
