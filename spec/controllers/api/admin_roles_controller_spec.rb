require 'rails_helper'

RSpec.describe Api::AdminRolesController, type: :controller do

  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    @user.add_role :admin
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  it "test update" do
    @user2 = create(:user2, user_type: "copper")

    patch :update, show_name: @user2.show_name, role: "gold", id: @user2.id
    expect(response.status).to eq(200)
  end

end
