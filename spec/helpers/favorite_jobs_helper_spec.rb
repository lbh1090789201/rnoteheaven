require 'rails_helper'

RSpec.describe Webapp::FavoriteJobsHelper, type: :helper do
  it 'test get_favorite_jobs' do
    user = create :user
    hospital = create :hospital
    job = create(:job, hospital_id: hospital.id)
    job2 = create(:job2, hospital_id: hospital.id)
    favorite_job = create :favorite_job, :job_id => job.id, :user_id => user.id
    favorite_job2 = create :favorite_job2, :job_id => job2.id, :user_id => user.id

    # favorite_jobs = get_favorite_jobs(user.id)
    # expect(favorite_jobs.size).to eq 0
  end
end
