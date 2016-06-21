require 'rails_helper'

RSpec.describe Employer::UsersController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    @user.add_role :gold
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]

    @hospital = create(:hospital)
    employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end
  end

end
