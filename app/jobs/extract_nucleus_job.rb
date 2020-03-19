class ExtractNucleusJob < ApplicationJob
  queue_as :extract_nucleus

  def perform(scanning_image)
    NucleusExtractorService.new(scanning_image).call
  end
end
