class ScannedCellsController < ApplicationController
  before_action :set_scanned_cell

  def show
    if params[:treat].present?
      data = treat
    else
      data = rgb
    end
    render json: data, status: :ok
  end

  def update
    if @scanned_cell.update analysis_label: params[:label]
      render json: {}, status: :ok
    else
      render json: @scanned_cell.errors.full_messages.first, status: :bad_request
    end
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

    def treat
      if @scanned_cell.blue.attached? and @scanned_cell.green.attached? and @scanned_cell.red.attached? and @scanned_cell.treated.attached?
        processed_cell = @scanned_cell
      else
        processed_cell = RemoveNoiseService.new(@scanned_cell).call
      end
      data = response_formatter(processed_cell)
      data[:treated] = processed_cell.treated_path
      data
    end

    def rgb
      if @scanned_cell.blue.attached? and @scanned_cell.green.attached? and @scanned_cell.red.attached? and (@scanned_cell.treated.attached? == false)
        processed_cell = @scanned_cell
      else
        processed_cell = ColorChannelExtractorService.new(@scanned_cell).call
      end
      data = response_formatter(processed_cell)
      data[:rgb] = processed_cell.rgb_path
      data
    end

end
