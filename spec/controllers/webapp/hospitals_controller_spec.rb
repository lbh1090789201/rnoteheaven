require 'rails_helper'

RSpec.describe Webapp::HospitalsController, type: :controller do
  describe "GET #show" do
    it "assigns the requested hospital to @hospital" do
      # hospital = create(:hospital)
      # get :show, id: hospital
      # expect(assigns(:hospital))== hospital
    end

    it "renders the :show template" do
      # hospital = create(:hospital)
      # get :show, id: hospital
      # expect(response).to render_template :show

    end
  end

  # describe "Get #index" do
  #   it "should have content 医才双选会" do
  #     visit webapp_hospitals_path
  #     expect(page).to have_content('医才双选会')
  #   end
  # end
end
