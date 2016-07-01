require 'rails_helper'

RSpec.describe Api::EmployerResumesController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    @user.add_role :gold
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 页面测试开始
  describe 'employer check resume' do
    before :each do
      @apply_record = create(:apply_record)
    end

    it 'returns http success for update status' do
      patch :update, format: :json, :apply_record_id => @apply_record.id, :resume_status => "不合适"
      expect(response.status).to eq(200)
    end

    it 'returns http success for has_new' do
      patch :update, format: :json, :apply_record_id => @apply_record.id, :has_new => false
      expect(response.status).to eq(200)
    end

  end

end
