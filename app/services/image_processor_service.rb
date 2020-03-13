require 'json'

class ImageProcessorService

  def initialize params
    @image = params[:image]
    @scanning = params[:scanning]
  end

  def call
    extract_image_data
    scanning_image = setup_scanning_image
    scanning_image.scanned_cells = scanned_cells
    scanning_image.save
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@image.key)
      result = `python3 /home/vagrant/fish-core/image_marker.py #{image_path}`
      @image_data = JSON.parse result
    end

    def setup_scanning_image
      scanning_image = ScanningImage.new({
        total_nucleus_found: @image_data["total"],
        valid_nucleus_found: @image_data["valid"],
        scanning: @scanning,
        })
      scanning_image.original.attach(io: File.open(@image_data["original"]), filename: 'original.png', content_type: 'image/png')
      scanning_image.marked_image.attach(io: File.open(@image_data["marked"]), filename: 'marked.png', content_type: 'image/png')
      scanning_image
    end

    def scanned_cells
      scanned_cells = []
      @image_data["nucleus"].each do |nucleus_path|
        cell = ScannedCell.new
        cell.image.attach(io: File.open(nucleus_path), filename: 'nucleus.png', content_type: 'image/png')
        scanned_cells << cell
      end
      scanned_cells
    end

end
