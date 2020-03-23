require 'rails_helper'

describe 'ColorChannelExtractorService' do

  describe "when ColorChannelExtractorService is called" do
    before :each do
      create(:fish_slice)
      create(:scanning)
      create(:scanning_image)
      @scanned_cell = create(:scanned_cell)
    end
    it 'is expected to fill color attachments' do
      processed_cell = ColorChannelExtractorService.new(@scanned_cell).call
      expect(processed_cell.blue.attached?).to be_truthy
      expect(processed_cell.green.attached?).to be_truthy
      expect(processed_cell.red.attached?).to be_truthy
      expect(processed_cell.blue_green.attached?).to be_truthy
      expect(processed_cell.blue_red.attached?).to be_truthy
      expect(processed_cell.green_red.attached?).to be_truthy
    end
    it 'is expected to schedule a job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        ColorChannelExtractorService.new(@scanned_cell).call
      }.to have_enqueued_job(RemoveColorChannelsImagesJob)
    end
  end

end
