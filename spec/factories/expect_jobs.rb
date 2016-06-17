FactoryGirl.define do
  factory :expect_job do
    name  "高级护士"
    job_type "nurse"
    location "广州"
    expected_salary_range "1000-3000"
    job_desc "good"
    is_top true
    is_top_at "2016-05"
  end
end
