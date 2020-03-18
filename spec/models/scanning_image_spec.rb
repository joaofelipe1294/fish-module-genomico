require 'rails_helper'

RSpec.describe ScanningImage, type: :model do

  describe "when creating a new scanning_image" do
    context "when missing required values" do
      before(:each) do
        fish_slice = create(:fish_slice)
        scanning = create(:scanning, fish_slice: fish_slice)
        @scanning_image = build(:scanning_image, scanning: create(:scanning))
      end
      after(:each) { expect(@scanning_image).to be_invalid }
      it 'scanning' do
        @scanning_image.scanning = nil
      end
    end
  end

end
