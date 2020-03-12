require 'rails_helper'

RSpec.feature "FishSlices::Scannings", type: :feature do

  before :each do
    create(:fish_slice, exam: build(:exam))
  end

  describe "when user intends to see a slice scannings" do
    context "when user is in slices view" do
      context "when slice doesn't have any scanning" do
        before(:each) { visit fish_slices_path }
        it 'is expected to dont render link to scannings' do
          expect(page).not_to have_selector '.scannings-from-fish-slice'
        end
      end
      context "when slice has a scanning" do
        before(:each) { create(:scanning, fish_slice: FishSlice.last) }
        context "when has one scanning" do
          before :each do
            visit fish_slices_path
            click_link class: 'scannings-from-fish-slice', match: :first
          end
          it 'is expected to render table with only one line' do
            expect(find_all(class: 'scanning').size).to eq 1
          end
        end
        context "when has more than one scanning" do
          before :each do
            create(:scanning, fish_slice: FishSlice.last)
            visit fish_slices_path
            click_link class: 'scannings-from-fish-slice', match: :first
          end
          it 'is expected to render a table with scannings' do
            expect(find_all(class: 'scanning').size).to eq 2
          end
        end
      end
    end
  end

end
