require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create Job" do
    job = build(:job)
    expect(job).to be_valid

  end
end
