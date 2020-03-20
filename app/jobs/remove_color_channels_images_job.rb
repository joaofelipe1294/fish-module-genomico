class RemoveColorChannelsImagesJob < ApplicationJob
  queue_as :clean_channel_images

  def perform(scanned_image)
    scanned_image.blue.purge
    scanned_image.green.purge
    scanned_image.red.purge
    scanned_image.blue_green.purge
    scanned_image.blue_red.purge
    scanned_image.green_red.purge
  end
end
