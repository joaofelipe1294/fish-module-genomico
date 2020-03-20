class ConvertAndMarkImageJob < ApplicationJob
  queue_as :mark_image

  def perform(params)
    scanning = params[:scanning]
    scanning.update process_status: :processing
    ImageMarkerService.new(params).call
  end
end
