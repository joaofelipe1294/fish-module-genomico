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
      load_files
      scanning_image = ScanningImage.new(scanning: @scanning, start_processing_at: DateTime.current, process_status: :marking_image)
      scanning_image.original.attach(io: original, filename: 'original-png.png', content_type: 'image/png')
      scanning_image.marked.attach(io: marked, filename: 'marked.png', content_type: 'image/png')
      scanning_image.save
      close_files
      scanning_image
    end

    def load_files
      @original =  File.open(@image_data["original"])
      @marked =  File.open(@image_data["marked"])
    end

    def close_files
      @original.close
      @marked.close
      File.delete(@image_data["original"])
      File.delete(@image_data["marked"])
    end

end
