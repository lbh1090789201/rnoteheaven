require 'rails_helper'

RSpec.describe Webapp::ResumesController, type: :controller do
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

  describe 'GET #preview' do
    it 'returns http success' do
      get :preview, id: @user.id
      expect(response.status).to eq(200)
    end
  end


  describe 'POST #create' do
    context 'when content is change' do
      it 'returns http success' do
        expect {
          post :create, id=>@user.id, user: attributes_for(:user)
          expect(:user)==(@user)
        }
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'locates the requested @user' do
        expect do
        patch :update, id: @user.id, user: attributes_for(:user)
        expect(assigns(:user))==(@user)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
      it 'delete http success' do
        expect do
        expect{
          delete :destroy, id: @user.id
        }.to change(Resume,:count).by(-1)
        end
      end

      it 'redirects to users#show' do
        expect do
        delete :destroy, id: @user
        expect(response).to redirect_to new_user_session_path
        end
      end
  end

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
