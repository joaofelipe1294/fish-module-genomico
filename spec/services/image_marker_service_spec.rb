require 'rails_helper'

describe 'ImageMarkerService' do

  describe "when ImageMarkerService is called" do
    before :each do
      create(:fish_slice)
      scanning = create(:scanning)
      @processed = ImageMarkerService.new({image: scanning.images.first, scanning: scanning}).call
    end
    it 'is expected to generate marked image' do
      expect(@processed.marked.attached?).to be_truthy
    end
    it 'is expected to generate original image' do
      expect(@processed.original.attached?).to be_truthy
    end
  end

end
