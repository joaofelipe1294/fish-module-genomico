require 'rails_helper'

RSpec.describe Scanning, type: :model do

  describe "creating a new scanning" do
    before(:each) { create(:fish_slice) }
    context "when required value is missing it is expected to be_invalid" do
      before(:each) { @scanning = build(:scanning) }
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
    context "when without default values" do
      it 'is expected to be waiting_start when created' do
        scanning = build(:scanning)
        scanning.valid?
        expect(scanning.waiting_start?).to be_truthy
      end
    end
  end

end
