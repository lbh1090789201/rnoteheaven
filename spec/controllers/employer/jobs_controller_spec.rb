require 'rails_helper'

RSpec.describe Employer::JobsController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    @user.add_role :gold
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET page " do
    before :each do
      @hospital = create(:hospital)
      @employer = create(:employer, hospital_id: @hospital.id, user_id: @user.id)
      @job = create(:job, hospital_id: @hospital.id)
    end

    it "index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "show returns http success" do
      get :show, id: @job.id
      expect(response).to have_http_status(:success)
    end
  end

end
