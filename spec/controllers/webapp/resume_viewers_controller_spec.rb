require 'rails_helper'

RSpec.describe Webapp::ResumeViewersController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body)}

  before :each do
    @user = create(:user)
    @resume_viewer = create :resume_viewer
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index, format: :html
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: @resume_viewer.id
      expect(response.status).to eq 200
    end
  end

end
