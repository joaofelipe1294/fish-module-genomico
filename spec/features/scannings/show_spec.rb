require 'rails_helper'

RSpec.feature "Scannings::Shows", type: :feature do

  before :each do
    fish_slice = create(:fish_slice, exam: build(:exam))
    @scanning = build(:scanning, fish_slice: fish_slice)
    @scanning.images.attach(io: File.open("#{Rails.root}/spec/support_images/SMALL_IMAGE.tif"), filename: 'some_image.tif', content_type: 'image/tif')
    @scanning.save
    visit scanning_path(@scanning)
  end

  it "check image data displayed" do
    expect(page).to have_selector '#responsible'
    expect(find(id: 'responsible').text).to match @scanning.responsible_login
    expect(page).to have_selector '#date'
    expect(find(id: 'date').text).to match I18n.l(@scanning.date)
    expect(page).to have_selector '#valid-nucleus'
    expect(find(id: 'valid-nucleus').text).not_to match "0"
    expect(page).to have_selector '.scanning-image-card'
    expect(find_all(class: 'scanning-image-card').size).to eq 1
  end

  it "check show and hide image", js: true do
    expect(page).not_to have_selector '.marked-image'
    click_button class: 'expand', match: :first
    expect(page).to have_selector '.marked-image'
    expect(page).not_to have_selector '.fa-plus'
    expect(page).to have_selector '.fa-minus'
    click_button class: 'expand', match: :first
    expect(page).not_to have_selector '.marked-image'
    expect(page).to have_selector '.fa-plus'
  end

  it "check full screen", js: true do
    click_button class: 'full-screen', match: :first
    expect(page).to have_selector '#image-lg'
  end

end
