FactoryGirl.define do
  factory :favorite_job, :class => 'FavoriteJob' do
    # association :user
    job_id 1
    user_id 1
    collected_at "2016-05-18 18:08:13"


  end
  factory :favorite_job2, :class => 'FavoriteJob' do
    # association :user
    job_id 2
    user_id 1
    collected_at "2016-05-18 18:08:13"


  end

end
