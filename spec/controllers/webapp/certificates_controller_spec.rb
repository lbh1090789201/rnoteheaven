require 'rails_helper'

RSpec.describe Webapp::CertificatesController, type: :controller do

  before :each do
    @user = create(:user)
    @certificate = create(:certificate, user_id: @user.id)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy, id: @certificate.id
      expect(response).to have_http_status(:success)
    end
  end

end
