require 'rails_helper'

RSpec.describe Webapp::ExpectJobsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      expect(:get => "/webapp/expect_jobs/:id/edit").to be_routable
    end
  end

  describe "GET #show" do
    it "returns http success" do
      expect(:get => "/webapp/expect_jobs/:id").to be_routable
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
