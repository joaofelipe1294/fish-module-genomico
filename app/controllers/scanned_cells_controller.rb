class ScannedCellsController < ApplicationController
  before_action :set_scanned_cell


  def show
    processed_cell = CollorChannelExtractor.new(@scanned_cell).call
    data = response_formatter(processed_cell)
    data[:rgb] = processed_cell.rgb_path
    render json: data, status: :ok
  end

  def treat
    processed_cell = RemoveNoiseService.new(@scanned_cell).call
    data = response_formatter(processed_cell)
    data[:treated] = processed_cell.treated_path
    render json: data, status: :ok
  end

  private

    def set_scanned_cell
      @scanned_cell = ScannedCell.find params[:id]
    end

    def response_formatter processed_cell
      {
        blue: processed_cell.blue_path,
        green: processed_cell.green_path,
        red: processed_cell.red_path,
        blue_green: processed_cell.blue_green_path,
        blue_red: processed_cell.blue_red_path,
        green_red: processed_cell.green_red_path,
      }
    end

end
