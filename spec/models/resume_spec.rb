require 'rails_helper'

RSpec.describe Resume, type: :model do
    it "has a valid factory" do
      expect(build(:resume)).to be_valid
    end  
end
