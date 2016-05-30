require 'rails_helper'

RSpec.describe Webapp::FavoriteJobsHelper, type: :helper do


  it 'test get_favorite_jobs' do
    favorite_job = create(:favorite_job)
    favorite_job2 = create(:favorite_job2)
    job = create(:job)
    job2 = create(:job2)

    res = get_favorite_jobs(1)
    expect(res.size).to eq 2

  end

end
