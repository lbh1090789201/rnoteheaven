require 'rails_helper'

RSpec.describe Employer::HomeController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

    before :each do
      @user = create(:user)
      @user.add_role :gold
      login_with @user
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

end
