require 'rails_helper'

RSpec.feature "FishSlices::Indices", type: :feature do

  before :each do
    visit root_path
  end

  describe "when user wants to see all fish_slices" do
    context "when user is on home page and click in slices link" do
      before(:each) { click_link class: 'fish-slices', match: :first }
      it 'is expected to be redirected to fish_slices_path' do
        expect(page).to have_current_path fish_slices_path
      end
      context "when user is on fish_slices view" do
        context "when there are more than 10 fish_slices" do
          before :each do
            15.times { create(:fish_slice, exam: build(:exam)) }
            visit fish_slices_path
          end
          it 'is expected to render only 10 each time' do
            expect(find_all(class: 'fish-slice').size).to eq 10
          end
          it 'is expected to have pagination' do
            expect(page).to have_selector '#pagination'
          end
        end
        context "when there are less than 10 slices" do
          before :each do
            8.times { create(:fish_slice, exam: build(:exam)) }
            visit fish_slices_path
          end
          it 'is expected to render all fish_slices' do
            expect(find_all(class: 'fish-slice').size).to eq 8
          end
        end
      end
    end
  end

end
