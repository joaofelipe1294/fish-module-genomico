class ScannedCellsController < ApplicationController

  def show
    cell = ScannedCell.find params[:id]
    cell = CollorChannelExtractor.new(cell).call
    data = {
      blue: cell.blue_path,
      green: cell.green_path,
      red: cell.red_path,
      blue_green: cell.blue_green_path,
      blue_red: cell.blue_red_path,
      green_red: cell.green_red_path,
      rgb: cell.rgb_path
    }
    render json: data, status: :ok
  end

end
