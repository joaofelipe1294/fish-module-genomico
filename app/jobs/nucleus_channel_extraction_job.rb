class NucleusChannelExtractionJob < ApplicationJob
  queue_as :default

  def perform(scanned_cell)
    CollorChannelExtractor.new(scanned_cell).call
  end
end
