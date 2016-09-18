require 'rails_helper'

RSpec.describe Admin::DataStatisticsController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }

    before :each do
      @user = create(:user)
      @user.add_role :admin
      login_with @user
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    # describe "test data_statistic method" do
    #   before :each do
    #     user2 = create :user2
    #     user3 = create(:user2, username: "asda", email: "109078@qq.com", cellphone: "13412312332")
    #     hospital = create :hospital
    #     job = create(:job, hospital_id: hospital.id)
    #     job2 = create(:job2, hospital_id: hospital.id)
    #     resume = create(:resume, user_id: user2.id)
    #     resume2 = create(:resume, user_id: user3.id)
    #     apply_record = create(:apply_record, resume_id: resume.id, user_id: user2.id, job_id: job.id, hospital_id: hospital.id)
    #     apply_record2 = create(:apply_record, resume_id: resume2.id, user_id: user3.id, job_id: job2.id, hospital_id: hospital.id)
    #   end
    #
    #   it "test get_hospital_delivers" do
    #     @times = ["2016-05-15 18:04:53", "2016-05-16 18:04:53", "2016-05-17 18:04:53", "2016-05-18 18:04:53", "2016-05-19 18:04:53", "2016-05-20 18:04:53"]
    #     @hospital_delivers = get_hospital_delivers("深圳第一医院")
    #     expect(@hospital_delivers).to eq([0, 0, 0, 1, 0])
    #   end
    # end

end
