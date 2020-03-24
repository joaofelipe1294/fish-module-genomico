require 'rails_helper'

RSpec.feature "ScanningImages::Shows", type: :feature do

  context "when user is in scanning_image#show view" do
    before :each do
      create(:fish_slice)
      scanning = create(:scanning)
      @scanning_image = create(:scanning_image)
      NucleusExtractorService.new(@scanning_image).call
      @scanning_image.reload.scanned_cells.each do |cell|
        ColorChannelExtractorService.new(cell).call
      end
      visit scanning_image_path(@scanning_image)
    end
    it 'is expected to render nucleusimages' do
      expect(page).to have_selector '.cell'
    end
    context "when user click in nucleus image", js: true do
      before(:each) { find(class: 'cell', match: :first).click }
      it 'is expected to render image card' do
        expect(page).to have_selector '#single-nucleus-card'
      end
      it 'is expected to render shade' do
        expect(page).to have_selector '#shade'
      end
      it 'is expected to render color channels buttons without outline' do
        expect(page).to have_selector '.with-blue'
        expect(page).to have_selector '.with-green'
        expect(page).to have_selector '.with-red'
      end
      it 'is expected to render btn treat image' do
        expect(page).to have_selector '#treated'
      end
      it 'is expected to render btn to change nucleus to negative' do
        expect(page).to have_selector '#mark-as-negative'
        expect(page).not_to have_selector '#mark-as-positive'
      end
    end
  end

end
