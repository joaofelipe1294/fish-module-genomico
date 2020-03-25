require 'rails_helper'

RSpec.feature "ScanningImages::ChangeLabels", type: :feature do

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
  describe 'change scanned cell label is appropriate' do
    context "when cell has label appropriate", js: true do
      before(:each) { find(class: 'cell', match: :first).click }
      it 'is expected to have success border' do
        expect(page).to have_selector '.appropriate'
      end
      it 'is expected to render mark-as-inappropriate button' do
        expect(page).to have_selector '#mark-as-inappropriate'
      end
      context "when click in mark-as-inappropriate button" do
        before(:each) { click_button id: 'mark-as-inappropriate' }
        it 'is expected to change border' do
          expect(page).to have_selector '.inappropriate'
        end
        it 'is expected to render mark-as-appropriate button' do
          expect(page).to have_selector '#mark-as-appropriate'
        end
        it 'is expected to change scanned_cell label' do
          expect(ScannedCell.inappropriate.count).to eq 1
        end
      end
    end
  end
  describe "when scanned cell label is inappropriate", js: true do
    before :each do
      ScannedCell.all.each { |cell| cell.update analysis_label: :inappropriate }
      visit scanning_image_path(@scanning_image)
      find(class: 'cell', match: :first).click
    end
    it 'is expected to render mark-as-appropriate button' do
      expect(page).to have_selector '#mark-as-appropriate'
    end
    it 'is expected to have danger-border' do
      expect(page).to have_selector '.inappropriate'
    end
    context "when user click in mark-as-posiutive button" do
      before(:each) { click_button id: 'mark-as-appropriate' }
      it 'is expected to render mark-as-inappropriate button' do
        expect(page).to have_selector '#mark-as-inappropriate'
      end
      it 'is expected to change label to appropriate' do
        expect(ScannedCell.appropriate.count).to eq 1
      end
      it 'is expected to change border to appropriate' do
        expect(page).to have_selector '.appropriate'
      end
    end
  end

end
