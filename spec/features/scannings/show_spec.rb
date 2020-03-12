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

end
