class ExtractNucleusJob < ApplicationJob
  queue_as :extract_nucleus

  def perform(scanning_image)
    NucleusExtractorService.new(scanning_image).call
    scanned_image.update process_status: :extracting_channels
  end
end
