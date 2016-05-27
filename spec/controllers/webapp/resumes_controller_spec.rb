require 'rails_helper'

RSpec.describe Webapp::ResumesController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

  # before :each do
  #   @user = create(:user)
  #   login_with @user
  #   request.env['devise.mapping'] = Devise.mappings[:user]
  # end

  # 测试
  # describe 'GET #index' do
  #   it 'returns http success' do
  #     get :index
  #     expect(response.status).to eq(200)
  #   end
  # end
  #
  # describe 'GET #show' do
  #   it 'returns http success' do
  #     get :show, id: @user.id
  #     expect(response.status).to eq(200)
  #   end
  # end
  #
  # describe 'GET #preview' do
  #   it 'returns http success' do
  #     get :preview, id: @user.id
  #     expect(response.status).to eq(200)
  #   end
  # end
  #
  # describe 'GET #edit' do
  #   it 'returns http success' do
  #     get :edit, id: @user.id
  #     expect(response.status).to eq(200)
  #   end
  # end

  # describe 'POST #create' do
  #   context 'when content is change' do
  #     it 'returns http success' do
  #       user = create(:user)
  #       post :create, session: { sex: "男", show_name: "lbh" }
  #       expect(response).to redirect_to webapp_resumes_path
  #     end
  #   end
  # end

#  describe "GET #index" do
    #it "returns http success" do
      #get :index
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #create" do
    #it "returns http success" do
      #get :create
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #new" do
    #it "returns http success" do
      #get :new
      #expect(response).to have_http_status(:success)
    #end
  #end

  # describe "Get #index" do
  #   it "should have content 我的简历" do
  #     visit webapp_resume_path(:id)
  #     expect(page).to have_content('我的简历')
  #   end
  # end

end
