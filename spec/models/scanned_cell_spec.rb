require 'rails_helper'

RSpec.describe ScannedCell, type: :model do

  describe "when creating a new scanned cell" do
    before :each do
      fish_slice = create(:fish_slice, exam: build(:exam))
      scanning = build(:scanning)
      scanning.images.attach(io: File.open("#{Rails.root}/spec/support_images/IMAGE001.tif"), filename: 'some_image.tif', content_type: 'image/tif')
      scanning.save
      scanning_image = scanning.reload.scanning_images.last
      @scanned_cell = build(:scanned_cell, scanning_image: scanning_image)
    end
    context "when without scanned cell without a required value" do
      it 'scanned_image' do
        @scanned_cell.scanning_image = nil
        expect(@scanned_cell).to be_invalid
      end
    end
    context "when without label" do
      it 'is expected to be valid' do
        expect(@scanned_cell.label).to eq :positive.to_s
      end
    end
  end

end
