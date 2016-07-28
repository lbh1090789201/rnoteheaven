require 'rails_helper'

RSpec.describe Api::ConnectAppController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  # 页面测试开始
    it 'returns http index' do
      @user = create(:user)
      get :index, userId: @user.user_number, token: "test"
      expect(response.status).to eq(302)
    end

    it 'test get_hospital' do
      @hospital = create(:hospital)

      post :get_hospital, telephone: @hospital.contact_number
      expect(response.status).to eq(200)
    end
end
