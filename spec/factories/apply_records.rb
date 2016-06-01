FactoryGirl.define do
  factory :apply_record, :class => 'ApplyRecord' do
    resume_id 1
    job_id 2
    user_id 2
    apply_at "2016-05-18 18:04:53"
    end_at "2016-05-18 18:04:53"
    resume_status "MyString"
    recieve_at "2016-05-18 18:04:53"
    view_at "2016-05-18 18:04:53"
  end

  factory :apply_record2, :class => 'ApplyRecord' do
    resume_id 1
    job_id 3
    user_id 2
    apply_at "2016-05-18 18:04:53"
    end_at "2016-05-18 18:04:53"
    resume_status "MyString"
    recieve_at "2016-05-18 18:04:53"
    view_at "2016-05-18 18:04:53"
  end
end
