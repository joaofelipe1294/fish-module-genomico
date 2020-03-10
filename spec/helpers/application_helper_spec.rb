require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'list_title' do
    before(:each) { @result = helper.list_title "Some model" }
    it 'is expected to have text-center' do
      expect(@result).to match "text-center"
    end
    it 'is expect to be an h2' do
      expect(@result).to match "h2"
    end
    it 'is expected to have mt-3' do
      expect(@result).to match "mt-3"
    end
    it "is expected to have a hr" do
      expect(@result).to match "<hr>"
    end
  end

end
