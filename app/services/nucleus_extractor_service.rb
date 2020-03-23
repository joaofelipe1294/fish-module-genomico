require 'json'

class NucleusExtractorService

  def initialize scanning_image
    @scanning_image = scanning_image
  end

  def call
    @scanning_image.update(process_status: :extracting_nucleus)
    extract_image_data
    nucleus_paths = @image_data["nucleus"]
    @scanning_image.update(valid_nucleus_found: nucleus_paths.size, total_nucleus_found: nucleus_paths.size)
    nucleus_paths.each do |image_path|
      cell = ScannedCell.new()
      image = File.open(image_path)
      cell.rgb.attach(io: image, filename: 'nucleus.png', content_type: 'image/png')
      cell.save
      @scanning_image.scanned_cells << cell
    end
    @scanning_image.update process_status: :complete, finish_processing_at: DateTime.current
  end

  private

    def extract_image_data
      image_path = ActiveStorage::Blob.service.path_for(@scanning_image.original.key)
      result = `python3 /opt/fish-core/nucleus_extractor.py #{image_path}`
      @image_data = JSON.parse result
    end

end
