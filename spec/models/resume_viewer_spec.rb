require 'rails_helper'

RSpec.describe ResumeViewer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "has a valid ResumeViewer factory" do
    expect(build(:resume_viewer)).to be_valid
  end
end
