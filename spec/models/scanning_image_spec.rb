require 'rails_helper'

RSpec.describe ScanningImage, type: :model do

  describe "when creating a new scanning_image" do
    before :each do
      create(:fish_slice)
      create(:scanning)
    end
    context "when missing required values" do
      before(:each) do
        @scanning_image = build(:scanning_image)
      end
      after(:each) { expect(@scanning_image).to be_invalid }
      it 'scanning' do
        @scanning_image.scanning = nil
      end
      it 'original' do
        @scanning_image.original = nil
      end
    end
    context "when without default values" do
      it 'is expected to be pending analysis status when creating' do
        scanning_image = build(:scanning_image)
        expect(scanning_image).to be_valid
        expect(scanning_image.analysis_status).to match "pending"
      end
    end
  end

end
