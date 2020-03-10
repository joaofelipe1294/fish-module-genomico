require 'rails_helper'

RSpec.describe Scanning, type: :model do

  describe "creating a new scanning" do
    context "when required value is missing it is expected to be_invalid" do
      before(:each) do
        fish_slice = create(:fish_slice)
        @scanning = build(:scanning)
      end
      after(:each) { expect(@scanning).to be_invalid}
      it 'responsible_id' do
        @scanning.responsible_id = nil
      end
      it 'responsible_login' do
        @scanning.responsible_login = ""
      end
      it 'date' do
        @scanning.date = nil
      end
      it 'fish_slice' do
        @scanning.fish_slice = nil
      end
    end
  end

end
