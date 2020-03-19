require 'rails_helper'

RSpec.feature "Scannings::News", type: :feature do
  include ActiveJob::TestHelper

  before :each do
    exam = build(:exam)
    create(:fish_slice, exam: exam)
    visit root_path
    click_link class: 'fish-slices'
  end

  describe "when user intent to create a new scannig", js: true do
    context "when user is in fish_slices view" do
      it 'is expected to render new scanning link' do
        expect(page).to have_selector '.new-scanning'
      end
      context "when user click in new scanning link" do
        before(:each) { click_link class: 'new-scanning', match: :first }
        it 'is expected to be redirected to new scanning view' do
          expect(page).to have_current_path(new_scanning_path, ignore_query: true)
        end
        context "when missing values is expected to render error message" do
          before(:each) { click_button id: 'btn-save' }
          it 'is expected to render error messages' do
            expect(page).to have_selector '.error'
          end
        end
        context "when fill ok" do
          before :each do
            visit new_scanning_path(slice_id: FishSlice.last.id)
            fill_in 'scanning[date]', with: Date.current
            attach_file "scanning[images][]", "#{Rails.root}/spec/support_images/SMALL_IMAGE.tif"
            click_button id: 'btn-save'
          end
          it 'is expected to be redirected to root_path' do
            expect(page).to have_current_path processing_progress_path
          end
          it 'is expected to save values' do
            scanning = Scanning.last
            expect(scanning.date).to eq Date.current
            expect(scanning.images.size).to eq 1
          end
          it 'is expected to queue image processing jobs' do
            expect(enqueued_jobs.empty?).to be_falsey
          end
          it 'is expected to display success message' do
            expect(find(id: 'success-message').text).to eq I18n.t :new_scanning_success
          end
        end
      end
    end
  end

end
