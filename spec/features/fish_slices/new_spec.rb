require 'rails_helper'

RSpec.feature "FishSlices::News", type: :feature do

  before(:each) { visit root_path }

  describe "when user intend to create a new slice" do
    context "when user click in new-slice link" do
      it 'is expected to redirect to new_slice_path' do
        click_link class: 'new-slice', match: :first
        expect(page).to have_current_path(new_fish_slice_path, ignore_query: true)
      end
    end
    context "when in new slice view" do
      before :each do
        click_link class: 'new-slice', match: :first
      end
      context "when fill all values", js: true do
        before :each do
          fill_in "fish_slice[date]", with: Date.current
          click_button id: 'btn-save'
        end
        it 'is expected to render success' do
          expect(find(id: 'success-message').text).to match I18n.t :new_fish_slice_success
        end
        it 'is expected to create slice' do
          expect(FishSlice.all.empty?).to be_falsey
        end
        it 'is expected to be redirected to root_path' do # by now
          expect(page).to have_current_path root_path
        end
      end
      context "when there are errors" do
        before :each do
          click_button id: 'btn-save'
        end
        it 'is expected to show error messages' do
          expect(page).to have_selector '.error'
        end
      end
    end
  end

end
