require 'rails_helper'

RSpec.describe FishSlice, type: :model do

  describe 'creating a new slice' do
    context "when required values are missing is expected o be invalid" do
      before(:each) { @slice = build(:fish_slice) }
      after(:each) { expect(@slice).to be_invalid }
      it 'responsible_id' do
        @slice.responsible_id = nil
      end
      it 'responsible_login' do
        @slice.responsible_login = nil
      end
      it 'date' do
        @slice.date = nil
      end
      it 'probe' do
        @slice.probe = nil
      end
      it 'genomico_exam_id' do
        @slice.genomico_exam_id = nil
      end
    end
    context "when all values are ok" do
      it 'is expected to be_valid' do
        slice = build(:fish_slice)
        expect(slice).to be_valid
      end
    end
  end

end
