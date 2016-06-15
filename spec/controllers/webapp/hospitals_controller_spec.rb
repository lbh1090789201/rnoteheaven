require 'rails_helper'

RSpec.describe Webapp::HospitalsController, type: :controller do
  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response.status).to eq 200
    end
  end

  # show 测试开始
  describe "GET #show" do
    it "assigns the requested hospital to @hospital" do
      hospital = create(:hospital)
      get :show, id: hospital.id
      expect(assigns(:hospital))== hospital
    end

    it "renders the :show template" do
      hospital = create(:hospital)
      get :show, id: hospital.id
      expect(response).to render_template :show
    end
  end

  describe "PATCH #update" do
    before :each do
      @hospital = create(:hospital)
    end

    context "valid attributes" do
      it "locates the requested @hospital" do
        expect do
          patch :update,id=>@user.id, hospital:attributes_for(:hospital)
          expect(assigns(:contact))==(@hospital)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @hospital = create(:hospital)
    end

    it "deletes the hospital" do
      expect do
        expect{delete :destroy, id=>@user.id}.to change(EducationExperience,:count).by(-1)
      end
    end

    it "redirects to hospital#index " do
      expect do
        delete :destroy, id=>@user.id
        expect(response).to redirect_to webapp_hospital_path
      end
    end
  end
  # describe "POST #create" do
  #   before :each do
  #     @hospital = create(:hospital)
  #   end
  #
  #   context "valid attributes" do
  #     it "saves the new @education_experience in the database" do
  #       expect{post :create, hospital:attributes_for(:hospital)}.to change(EducationExperience, :count).by(1)
  #     end
  #   end
  # end
  # describe "Get #index" do
  #   it "should have content 医才双选会" do
  #     visit webapp_hospitals_path
  #     expect(page).to have_content('医才双选会')
  #   end
  # end
end
