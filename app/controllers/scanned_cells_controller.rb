class ScannedCellsController < ApplicationController

  def show
    cell = ScannedCell.find params[:id]
    # puts "================================="
    # p cell.rgb.attached?
    # puts "================================="
    
    render json: {pendejo: 'soy loko man'}
  end

end
