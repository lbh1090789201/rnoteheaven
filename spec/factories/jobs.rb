FactoryGirl.define do
  factory :job, :class => 'Job' do
    id 1
    name "MyString"
    salary_range "MyString"
    location "MyString"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    is_top false
    is_top_at "2016-05-18 17:56:53"
  end

  factory :job2, :class => 'Job' do
    id 2
    name "MyString"
    salary_range "MyString"
    location "MyString"
    job_desc "MyString"
    needed_number 1
    job_type "MyString"
    is_top true
    is_top_at "2016-05-18 17:56:53"
  end

end
