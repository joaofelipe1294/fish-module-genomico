require 'rails_helper'

RSpec.feature "Home::Indices", type: :feature do

  describe "when user visit home page" do
    before(:each) { visit root_path }
    it 'is expected to render exams table' do
      expect(page).to have_selector 'table'
    end
    it 'is expected to render all open exams' do
      expect(find_all(class: 'exam').size).to eq 2 # mock returns 2 exams
    end
  end

end
