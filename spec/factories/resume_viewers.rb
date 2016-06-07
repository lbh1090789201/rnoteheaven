FactoryGirl.define do
  factory :resume_viewer, :class => 'ResumeViewer' do
    user_id 1
    hospital_id 1
    view_at "2016-05-18 18:10:25"
  end

  factory :resume_viewer2, :class => 'ResumeViewer' do
    user_id 1
    hospital_id 2
    view_at "2016-05-18 18:10:25"
  end

end
