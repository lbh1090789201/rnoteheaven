require 'rails_helper'

RSpec.describe Webapp::JobFairsController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

  before :each do
    @user = create(:user)
    login_with @user
    request.env['devise.mapping'] = Devise.mappings[:user]

    @fair = create(:fair)
  end

  # 测试
  it 'returns http success' do
    get :index, format: :html
    expect(response.status).to eq(200)
  end

  describe 'GET #show' do
    it 'returns hettp success' do
      get :show, id: @fair.id
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    it 'returns hettp success' do
      get :edit, id: @user.id
      expect(response.status).to eq(200)
    end
  end

  # describe 'POST #create' do
  #   context 'when sex is invalid' do
  #     it 'renders the page with error' do
  #
  #       post :create, session: { id: @user.id, sex: '女' }, format: :html
  #
  #       expect(response).to render_template(:show, @user.id)
  #       expect(flash[:notice]).to match(/^Email and password do not match/)
  #     end
  #   end
  # end

  # describe 'PATCH #update' do
  #   before :each do
  #     @user = create(:user, username: 'infos', email: 'users@example.com',sex: '女')
  #   end
  #
  #   it "changes @user's attributes" do
  #     patch :update, id: @user.id,
  #           user:attributes_for(:user, sex: '人妖')
  #     @user.reload
  #     expect(@user.sex).to eq('人妖')
  #   end
  # end





end
