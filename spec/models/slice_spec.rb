require 'rails_helper'

RSpec.describe Slice, type: :model do

  describe 'creating a new slice' do
    context "when required values are missing is expected o be invalid" do
      before(:each) { @slice = build(:slice) }
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
      it 'subsample_id' do
        @slice.subsample_id = nil
      end
      it 'subsample_label' do
        @slice.subsample_label = ''
      end
      it 'probe' do
        @slice.probe = nil
      end
    end
    context "when all values are ok" do
      it 'is expected to be_valid' do
        slice = build(:slice)
        expect(slice).to be_valid
      end
    end
  end

end
