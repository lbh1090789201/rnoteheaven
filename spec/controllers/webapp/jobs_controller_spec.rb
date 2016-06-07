require 'rails_helper'

RSpec.describe Webapp::JobsController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 页面测试开始
  describe 'get #index #show' do
    before :each do
      @job = create :job
    end

    it 'returns http success' do
      get :index, format: :html
      expect(response.status).to eq(200)
    end

    it 'returns http success' do
      get :show, id: @job.id, format: :html
      expect(response.status).to eq(200)
    end
  end

end
