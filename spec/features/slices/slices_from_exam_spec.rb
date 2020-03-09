require 'rails_helper'

RSpec.feature "Slices::SlicesFromExams", type: :feature do

  before(:each) { visit root_path }

  describe "slices_from_exam" do
    context "when user is in home page" do
      context "when exams has no slices" do
        it 'is expected not to render slices-from-exam link' do
          expect(page).not_to have_selector '.slices-from-exam'
        end
      end
      context "when exam has one slice", js: true do
        before :each do
          click_link class: 'new-slice', match: :first
          fill_in 'slice[date]', with: Date.current
          click_button id: 'btn-save'
          visit root_path
        end
        it 'is expected to render slices-from-exam link' do
          expect(page).to have_selector '.slices-from-exam'
        end
        context "when click in slices from exam link" do
          before(:each) { click_link class: 'slices-from-exam', match: :first }
          it 'is expected to be redirected to slices-from-exam path' do
            exam_id = Slice.last.exam_id
            expect(page).to have_current_path slices_from_exam_path(exam_id)
          end
          it "is expected to render all slices" do
            expect(find_all(class: 'slice').size).to eq 1
          end
        end
      end
    end
  end

end
