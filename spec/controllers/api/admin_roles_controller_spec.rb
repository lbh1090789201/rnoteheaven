require 'rails_helper'

RSpec.describe Api::ApplyRecordsController, type: :controller do

  render_views
  let (:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
end
