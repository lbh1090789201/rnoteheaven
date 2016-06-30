FactoryGirl.define do
  factory :job, :class => 'Job' do
    hospital_id 1
    name "护士"
    salary_range "2000-5000"
    location "深圳市"
    region "深圳市"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    status "saved"
    refresh_at Time.now - 3.days
    submit_at Time.now
    end_at Time.now + 60.days
  end

  factory :job2, :class => 'Job' do
    hospital_id 2
    name "护士"
    salary_range "3000-6000"
    location "成都"
    region "成都"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    refresh_at Time.now - 3.days
  end

  factory :job3, :class => 'Job' do
    hospital_id 1
    name "医生"
    salary_range "3000-7000"
    location "深圳"
    region "深圳"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    refresh_at Time.now - 3.days
  end

  factory :job4, :class => 'Job' do
    hospital_id 2
    name "医生"
    salary_range "3000-7000"
    location "成都"
    region "成都"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    refresh_at Time.now - 3.days
  end

end
