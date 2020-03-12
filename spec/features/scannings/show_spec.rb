require 'rails_helper'

RSpec.feature "Scannings::Shows", type: :feature do

  before :each do
    fish_slice = create(:fish_slice, exam: build(:exam))
    @scanning = build(:scanning, fish_slice: fish_slice)
    @scanning.images.attach(io: File.open("#{Rails.root}/spec/support_images/IMAGE001.tif"), filename: 'some_image.tif', content_type: 'image/tif')
    @scanning.save
    visit scanning_path(@scanning)
  end

  describe "when user is in show scanning view" do
    describe "when show image info" do
      it 'is expected to show image reference' do
        expect(page).to have_selector '#responsible'
        expect(find(id: 'responsible').text).to match @scanning.responsible_login
      end
      it 'is expected to show capture date' do
        expect(page).to have_selector '#date'
        expect(find(id: 'date').text).to match I18n.l(@scanning.date)
      end
      it 'is expected to show total nucleus' do
        expect(page).to have_selector '#valid-nucleus'
        expect(find(id: 'valid-nucleus').text).not_to match "0"
      end
      it "is expected to render a panel to each image" do
        expect(page).to have_selector '.scanning-image-card'
        expect(find_all(class: 'scanning-image-card').size).to eq 1
      end
    end
  end

  describe "display and hide image", js: true do
    context "when user go to show view" do
      it 'is expected to not have any image open' do
        expect(page).not_to have_selector '.marked-image'
      end
      context "when click in expand button" do
        before(:each) { click_button class: 'expand', match: :first }
        it 'is expected to render image' do
          expect(page).to have_selector '.marked-image'
        end
        it 'is expected to change button icon' do
          expect(page).not_to have_selector '.fa-plus'
          expect(page).to have_selector '.fa-minus'
        end
      end
      context "when image is rendered and click on hide button" do
        before :each do
          click_button class: 'expand', match: :first
          click_button class: 'expand', match: :first
        end
        it 'is expected to hide image' do
          expect(page).not_to have_selector '.marked-image'
        end
        it 'is expected to change button icon' do
          expect(page).to have_selector '.fa-plus'
        end
      end
    end
  end

end
