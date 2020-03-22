require 'rails_helper'

RSpec.describe User, type: :model do

  describe "User.all" do
    
    it 'is expected to return a list with only one user' do
      users = User.all
      expect(users.empty?).to be_falsey
    end

  end

end
