require 'rails_helper'

RSpec.describe Api::JobsController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 页面测试开始
  describe 'post to search jobs' do
    before :each do
      @hospital1 = create :hospital
      @hospital2 = create :hospital2
      @job = create :job, :hospital_id => @hospital1.id
      @job2 = create :job2, :hospital_id => @hospital2.id
      @job3 = create :job3, :hospital_id => @hospital1.id
      @job4 = create :job4, :hospital_id => @hospital2.id
    end

    it 'returns http success' do
      filter = {:job_name => @job.name}
      post :search, format: :json, filter: filter
      # puts response.body.to_s
      expect(response.status).to eq(200)
    end

    it '智能搜索' do
      filter = {:hospital_name => @job.name}
      post :search, format: :json, filter: filter
      # puts Hospital.all.to_json.to_s
      # puts response.body.to_s
      jobs = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(jobs["jobs"].size).to eq(2)
    end
  end

end
