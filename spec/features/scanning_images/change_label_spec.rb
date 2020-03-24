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
  describe 'change scanned cell label is positive' do
    context "when cell has label positive", js: true do
      before(:each) { find(class: 'cell', match: :first).click }
      it 'is expected to have success border' do
        expect(page).to have_selector '.positive'
      end
      it 'is expected to render mark-as-negative button' do
        expect(page).to have_selector '#mark-as-negative'
      end
      context "when click in mark-as-negative button" do
        before(:each) { click_button id: 'mark-as-negative' }
        it 'is expected to change border' do
          expect(page).to have_selector '.negative'
        end
        it 'is expected to render mark-as-positive button' do
          expect(page).to have_selector '#mark-as-positive'
        end
        it 'is expected to change scanned_cell label' do
          expect(ScannedCell.negative.count).to eq 1
        end
      end
    end
  end
  describe "when scanned cell label is negative", js: true do
    before :each do
      ScannedCell.all.each { |cell| cell.update label: :negative }
      visit scanning_image_path(@scanning_image)
      find(class: 'cell', match: :first).click
    end
    it 'is expected to render mark-as-positive button' do
      expect(page).to have_selector '#mark-as-positive'
    end
    it 'is expected to have danger-border' do
      expect(page).to have_selector '.negative'
    end
    context "when user click in mark-as-posiutive button" do
      before(:each) { click_button id: 'mark-as-positive' }
      it 'is expected to render mark-as-negative button' do
        expect(page).to have_selector '#mark-as-negative'
      end
      it 'is expected to change label to positive' do
        expect(ScannedCell.positive.count).to eq 1
      end
      it 'is expected to change border to positive' do
        expect(page).to have_selector '.positive'
      end
    end
  end

end
