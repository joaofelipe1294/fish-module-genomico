require 'rails_helper'

RSpec.describe ScannedCell, type: :model do
  before :each do
    fish_slice = create(:fish_slice, exam: build(:exam))
    scanning = build(:scanning)
    file = File.open("#{Rails.root}/spec/support_images/SMALL_IMAGE.tif")
    scanning.images.attach(io: file, filename: 'some_image.tif', content_type: 'image/tif')
    scanning.save
    file.close
    create(:scanning_image)
    @scanned_cell = build(:scanned_cell)
  end

  describe "when creating a new scanned cell" do
    it 'is expected to be_invalid when without scanned_image' do
      @scanned_cell.scanning_image = nil
      expect(@scanned_cell).to be_invalid
    end
    it 'is expected to be valid' do
      expect(@scanned_cell.label).to eq :positive.to_s
      expect(@scanned_cell).to be_valid
    end
    it 'is expected to be_invalid when without rgb attachment' do
      @scanned_cell.rgb = nil
      expect(@scanned_cell).to be_invalid
    end
  end

  describe "attachment _path method" do
    it "is expected to return image path when it has the attachment" do
      expect(@scanned_cell.rgb_path).not_to be_empty
    end
    it 'is expected to return nil when without attached element' do
      @scanned_cell.rgb = nil
      expect { @scanned_cell.rgb_path }.to raise_error(an_instance_of(Module::DelegationError))
    end
  end

end
