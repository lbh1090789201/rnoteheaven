FactoryGirl.define do
  factory :resume do
    refresh_at Time.now
    expected_job "护士"
    expected_job_type "全职"
    expected_base "北京"
    expected_salary_range "5k~6k"
    maturity 5
  end
end
