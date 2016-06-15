require 'rails_helper'

RSpec.describe ExpectJob, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create ExpectJob" do
    expect_job = create(:expect_job)
    expect_job = create(:expect_job, name:"doc", job_type:"护士", location:"北京", expected_salary_range:"5000-8000")
    expect_job = build(:expect_job)
    expect(expect_job).to be_valid
  end
end
