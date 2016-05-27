require 'rails_helper'

RSpec.describe ResumeView, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid ResumeView factory" do
    expect(build(:resume_view)).to be_valid
  end
end
