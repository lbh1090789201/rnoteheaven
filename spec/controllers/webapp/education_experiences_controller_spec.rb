require 'rails_helper'

RSpec.describe Webapp::EducationExperiencesController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  # 页面测试开始

  describe "GET #show" do
    it "returns http success" do
      get :show, id: @user.id
      expect(response).to have_http_status(:success)
    end
  end
  #测试 post
  # context "POST #create" do
  #   it "returns http success" do
  #     post :create
  #     expect(response).to have_http_status(:success)
  #
  #   end
  # end
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
# POST
  # describe "POST #create" do
  #   before :each do
  #     @education_experience = create(:education_experience)
  #   end
  #
  #   context "valid attributes" do
  #     it "saves the new @education_experience in the database" do
  #       expect{post :create, education_experience:attributes_for(:education_experience)
  #       }.to change(EducationExperience, :count).by(1)
  #     end
  #   end
  # end

  describe "PATCH #update" do
    before :each do
      @education_experience = create(:education_experience)
    end

    context "valid attributes" do
      it "locates the requested @education_experience" do
        expect do
          patch :update,id=>@user.id, education_experience:attributes_for(:education_experience)
          expect(assigns(:contact))==(@education_experience)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @education_experience = create(:education_experience)
    end

    it "deletes the education_experience" do
      expect do
        expect{delete :destroy, id=>@user.id}.to change(EducationExperience,:count).by(-1)
      end
    end

    it "redirects to education_experience#index " do
      expect do
        delete :destroy, id=>@user.id
        expect(response).to redirect_to webapp_education_experiences_path
      end
    end
  end

end
