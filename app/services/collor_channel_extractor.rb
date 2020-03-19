require 'json'

class CollorChannelExtractor

  def initialize scanned_cell
    @scanned_cell = scanned_cell
  end

  def call
    extract_image_data
    blue = File.open(@image_data["channels"]["blue"])
    green = File.open(@image_data["channels"]["green"])
    red = File.open(@image_data["channels"]["red"])
    blue_green = File.open(@image_data["channels"]["blue-green"])
    blue_red = File.open(@image_data["channels"]["blue-red"])
    green_red = File.open(@image_data["channels"]["green-red"])
    @scanned_cell.images.attach(io: blue, filename: 'blue_nucleus.png', content_type: 'image/png')
    @scanned_cell.images.attach(io: green, filename: 'green_nucleus.png', content_type: 'image/png')
    @scanned_cell.images.attach(io: red, filename: 'red_nucleus.png', content_type: 'image/png')
    @scanned_cell.images.attach(io: blue_green, filename: 'blue_green_nucleus.png', content_type: 'image/png')
    @scanned_cell.images.attach(io: blue_red, filename: 'blue_red_nucleus.png', content_type: 'image/png')
    @scanned_cell.images.attach(io: green_red, filename: 'green_red_nucleus.png', content_type: 'image/png')
    blue.close
    green.close
    red.close
    blue_green.close
    blue_red.close
    green_red.close
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@scanned_cell.rgb.key)
      result = `python3 /home/vagrant/fish-core/channel_extractor.py #{image_path}`
      @image_data = JSON.parse result
    end

end
