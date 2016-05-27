require 'rails_helper'

RSpec.describe Webapp::WorkExperiencesController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # 测试
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: @user.id
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, id: @user.id
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: @user.id
      expect(response.status).to eq(200)
    end
  end


end
