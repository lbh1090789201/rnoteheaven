require 'rails_helper'

RSpec.describe Webapp::ApplyRecordsController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 页面测试开始

  describe 'test #index #show ... ' do
    before :each do
      @hospital = create(:hospital)
      @job = create(:job, hospital_id: @hospital.id)

      @apply_record = create(:apply_record, user_id: @user.id, job_id: @job.id)
    end

    it 'returns http success' do
      get :index, format: :html
      expect(response.status).to eq(200)
    end

    it 'returns http success' do
      get :show, id: @apply_record.id, format: :html
      expect(response.status).to eq(200)
    end
  end



  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
