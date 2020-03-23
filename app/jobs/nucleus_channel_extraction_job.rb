class NucleusChannelExtractionJob < ApplicationJob
  queue_as :extract_channels

  def perform(scanned_cell)
    scanned_cell.update process_status: :processing
    ColorChannelExtractorService.new(scanned_cell).call
    scanned_cell.update process_status: :complete
  end
end
