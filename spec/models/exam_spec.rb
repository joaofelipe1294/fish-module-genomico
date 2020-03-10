require 'rails_helper'

RSpec.describe Exam, type: :model do

  describe "when creating a new exam" do
    context "when required values are missing is expected to be_invalid" do

      before(:each) do
        create(:fish_slice)
        @exam = build(:exam)
      end
      after(:each) { expect(@exam).to be_invalid }
      it 'name' do
        @exam.name = ''
      end
      it 'patient' do
        @exam.patient = ''
      end
      it 'subsample_label' do
        @exam.subsample_label = ""
      end
      it 'fish_slice' do
        @exam.fish_slice = nil
      end
      it 'start_date' do
        @exam.start_date = nil
      end
      it 'genomico_exam_id' do
        @exam.genomico_exam_id = nil
      end
    end
  end

end
