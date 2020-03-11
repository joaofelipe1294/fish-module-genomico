require 'json'

class ImageProcessorService

  def initialize params
    @image = params[:image]
    @scanning = params[:scanning]
  end

  def call
    image_path = ActiveStorage::Blob.service.path_for(@image.key)
    result = `python3 /home/vagrant/fish-core/image_marker.py #{image_path}`
    image_data = JSON.parse result
    scanning_image = ScanningImage.new({
      total_nucleus_found: image_data["total"],
      valid_nucleus_found: image_data["valid"],
      scanning: @scanning,
      })
    scanning_image.original.attach(io: File.open(image_data["original"]), filename: 'original.png', content_type: 'image/png')
    scanning_image.marked_image.attach(io: File.open(image_data["marked"]), filename: 'marked.png', content_type: 'image/png')
    scanning_image.save
  end

end
