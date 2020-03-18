require 'json'

class ImageMarkerService

  def initialize params
    @image = params[:image]
    @scanning = params[:scanning]
  end

  def call
    set_image_data
    @scanning_image = setup_scanning_image
    @scanning_image.save
  end

  private

    def set_image_data
      image_path = ActiveStorage::Blob.service.path_for(@image.key)
      result = `python3 /home/vagrant/fish-core/convert_and_mark_image.py #{image_path}`
      @image_data = JSON.parse result
    end

    def setup_scanning_image
      scanning_image = ScanningImage.new(scanning: @scanning)
      scanning_image.png_image.attach(io: File.open(@image_data["original"]), filename: 'original.png', content_type: 'image/png')
      scanning_image.marked_image.attach(io: File.open(@image_data["marked"]), filename: 'marked.png', content_type: 'image/png')
      scanning_image
    end

end
