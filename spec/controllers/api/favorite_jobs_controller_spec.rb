require 'rails_helper'

RSpec.describe Api::FavoriteJobsController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 页面测试开始
  describe '收藏职位' do
    before :each do
      @hospital1 = create :hospital
      @hospital2 = create :hospital2
      @job = create :job, :hospital_id => @hospital1.id
      @job2 = create :job2, :hospital_id => @hospital2.id
      @job3 = create :job3, :hospital_id => @hospital1.id
      @job4 = create :job4, :hospital_id => @hospital2.id
    end

    it '收藏职位' do
      p = {:job_id => @job.id}
      post :create, format: :json, favorite_job: p
      expect(response.status).to eq(200)
    end

  end

end
