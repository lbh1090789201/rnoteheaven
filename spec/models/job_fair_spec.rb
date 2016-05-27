require 'rails_helper'

RSpec.describe JobFair, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create JobFair" do
    job_fair = build(:job_fair)
    expect(job_fair).to be_valid

  end
end
