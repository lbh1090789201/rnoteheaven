FactoryGirl.define do
  factory :resume_view1, :class => 'ResumeView' do
    user_id 1
    hospital_id 1
    view_at "2016-05-18 18:10:25"
  end

  factory :resume_view2, :class => 'ResumeView' do
    user_id 1
    hospital_id 2
    view_at "2016-05-18 18:10:25"
  end

end
