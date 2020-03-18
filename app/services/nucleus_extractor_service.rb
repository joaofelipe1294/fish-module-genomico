require 'json'

class NucleusExtractorService

  def initialize scanning_image
    @scanning_image = scanning_image
  end

  def call
    extract_image_data
    nucleus_paths = @image_data["nucleus"]
    @scanning_image.update(valid_nucleus_found: nucleus_paths.size, total_nucleus_found: nucleus_paths.size)
    nucleus_paths.each do |image_path|
      cell = ScannedCell.new()
      image = File.open(image_path)
      cell.images.attach(io: image, filename: 'nucleus.png', content_type: 'image/png')
      cell.save
      @scanning_image.scanned_cells << cell
    end
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@scanning_image.png_image.key)
      result = `python3 /home/vagrant/fish-core/nucleus_extractor.py #{image_path}`
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

end
