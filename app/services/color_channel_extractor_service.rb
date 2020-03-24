require 'json'
require './app/services/file_manager'

class ColorChannelExtractorService
  include FileManager

  def initialize scanned_cell
    @scanned_cell = scanned_cell
  end

  def call
    extract_image_data
    load_files
    @scanned_cell.blue.attach(io: @blue, filename: 'blue_nucleus.png', content_type: 'image/png')
    @scanned_cell.green.attach(io: @green, filename: 'green_nucleus.png', content_type: 'image/png')
    @scanned_cell.red.attach(io: @red, filename: 'red_nucleus.png', content_type: 'image/png')
    @scanned_cell.blue_green.attach(io: @blue_green, filename: 'blue_green_nucleus.png', content_type: 'image/png')
    @scanned_cell.blue_red.attach(io: @blue_red, filename: 'blue_red_nucleus.png', content_type: 'image/png')
    @scanned_cell.green_red.attach(io: @green_red, filename: 'green_red_nucleus.png', content_type: 'image/png')
    @scanned_cell.save
    close_files
    purge_files
    RemoveColorChannelsImagesJob.set(wait: 5.minutes).perform_later(@scanned_cell)
    @scanned_cell
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@scanned_cell.rgb.key)
      result = `python3 /opt/fish-core/channel_extractor.py #{image_path}`
      @image_data = JSON.parse result
    end

end
