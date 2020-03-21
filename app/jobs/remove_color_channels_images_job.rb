class RemoveColorChannelsImagesJob < ApplicationJob
  queue_as :clean

  def perform(cell)
    cell.blue.purge
    cell.green.purge
    cell.red.purge
    cell.blue_green.purge
    cell.blue_red.purge
    cell.green_red.purge
  end
end
