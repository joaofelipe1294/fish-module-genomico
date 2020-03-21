require 'json'

class RemoveNoiseService
  include FileManager

  def initialize scanned_cell
    @cell = scanned_cell
  end

  def call
    extract_image_data
    load_files
    treated = File.open(@image_data["channels"]["treated"])
    @cell.treated.attach(io: treated, filename: 'treated.png', content_type: 'image/png')
    @cell.blue.attach(io: @blue, filename: 'blue_nucleus.png', content_type: 'image/png')
    @cell.green.attach(io: @green, filename: 'green_nucleus.png', content_type: 'image/png')
    @cell.red.attach(io: @red, filename: 'red_nucleus.png', content_type: 'image/png')
    @cell.blue_green.attach(io: @blue_green, filename: 'blue_green_nucleus.png', content_type: 'image/png')
    @cell.blue_red.attach(io: @blue_red, filename: 'blue_red_nucleus.png', content_type: 'image/png')
    @cell.green_red.attach(io: @green_red, filename: 'green_red_nucleus.png', content_type: 'image/png')
    treated.close
    close_files
    File.delete(@image_data["channels"]["treated"])
    purge_files
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@cell.rgb.key)
      result = `python3 /home/vagrant/fish-core/treat_noise.py #{image_path}`
      @image_data = JSON.parse result
    end

end
