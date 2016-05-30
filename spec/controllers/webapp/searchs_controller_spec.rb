require 'rails_helper'

RSpec.describe Webapp::SearchsController, type: :controller do
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

  describe 'GET #edit' do
    it 'returns hettp success' do
      get :edit, id: @user.id
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #search' do
    it 'returns hettp success' do
      get :search, id: @user.id
      expect(response.status).to eq(200)
    end
  end













  # describe "GET #index" do
  #   it "returns http success" do
  #     visit webapp_searchs_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get webapp_search_path(:id)
  #     expect(response).to have_http_status(:success)
  #   end
  # end



end
