require 'rails_helper'

RSpec.describe ScannedCell, type: :model do

  describe "when creating a new scanned cell" do
    before :each do
      fish_slice = create(:fish_slice, exam: build(:exam))
      scanning = build(:scanning)
      file = File.open("#{Rails.root}/spec/support_images/SMALL_IMAGE.tif")
      scanning.images.attach(io: file, filename: 'some_image.tif', content_type: 'image/tif')
      scanning.save
      file.close
      scanning_image = create(:scanning_image)
      @scanned_cell = build(:scanned_cell, scanning_image: scanning_image)
    end
    context "with rgb attached image" do
      before :each do
        nucleus_image = File.open("#{Rails.root}/spec/support_images/NUCLEUS.png")
        @scanned_cell.rgb.attach(io: nucleus_image, filename: 'nucleus.png', content_type: 'image/png')
      end
      it 'is expected to be_invalid when without scanned_image' do
        @scanned_cell.scanning_image = nil
        expect(@scanned_cell).to be_invalid
      end
      it 'is expected to be valid' do
        expect(@scanned_cell.label).to eq :positive.to_s
        expect(@scanned_cell).to be_valid
      end
    end
    it 'is expected to be_invalid when without rgb attachment' do
      expect(@scanned_cell).to be_invalid
    end
  end

end
