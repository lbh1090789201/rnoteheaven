require 'rails_helper'

RSpec.describe Admin::VipsController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

    before :each do
      @user = create(:user)
      @user.add_role :admin
      login_with @user
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

  describe "test pages connect" do
    it "GET #index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end