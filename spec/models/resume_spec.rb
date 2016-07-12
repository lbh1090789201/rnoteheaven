require 'rails_helper'

RSpec.describe Resume, type: :model do

    it "has a valid factory" do
      expect(build(:resume)).to be_valid
    end

    it "test filter filter_maturity num" do
      @resume = create(:resume, maturity: 80)
      @resume2 = create(:resume, maturity: 70)

      res = Resume.filter_maturity(70)

      expect(res.length).to eq(1)
    end

    it "test filter_no_freeze filter_is_freeze" do
      @resume = create(:resume, resume_freeze: true)
      @resume2 = create(:resume)
      @resume3 = create(:resume)

      res = Resume.filter_no_freeze
      res2= Resume.filter_is_freeze

      expect(res.length).to eq(2)
      expect(res2.length).to eq(1)
    end

    it "test filter_is_public" do
      @resume = create(:resume, public: false)
      @resume2 = create(:resume)

      res = Resume.filter_is_public "false"
      expect(res[0].public).to eq(false)
    end

    it "test refresh_left" do
      @resume = create(:resume, refresh_at: Time.now - 3.days)
      @resume2 = create(:resume, refresh_at: Time.now - 8.days)
      @resume3 = create(:resume, refresh_at: nil)
      res = Resume.refresh_left(@resume.id)
      res2 = Resume.refresh_left(@resume2.id)
      res3 = Resume.refresh_left(@resume3.id)

      expect(res).to eq(4)
      expect(res2).to eq(false)
      expect(res3).to eq(false)
    end

    it "test Resume.info" do
      @user = create(:user)
      @resume = create(:resume, user_id: @user.id)
      @expect_job = create(:expect_job, user_id: @user.id)

      res = Resume.info @user.id
      expect(res.length).to eq(10)
    end

    describe "test filter" do
      before :each do
        @user = create(:user, location: "武汉", show_name: "Ming")
        @resume = create(:resume, user_id: @user.id)
      end

      it "test filter_by_city" do
        res = Resume.filter_by_city "武汉"
        expect(res.length).to eq(1)
      end

      it "test filter_show_name" do
        res = Resume.filter_show_name "Ming"
        expect(res.length).to eq(1)
      end

      it "test filter_is_block" do
        hospital = create(:hospital)
        block_hospital = create(:block_hospital, user_id: @user.id, hospital_id: hospital.id)

        res_all = Resume.all
        res = Resume.filter_is_block hospital.id
        expect(res_all.length).to eq(1)
        expect(res.length).to eq(0)
      end
    end

    # 测试 Admin 获取简历相关信息
    it "test Resume get_info resume" do
      @user = create(:user, location: "武汉", show_name: "Ming")
      @resume = create(:resume, user_id: @user.id)
      @apply_record = create(:apply_record, user_id: @user.id)
      @apply_record = create(:apply_record, user_id: @user.id, job_id: 22)
      @resume_viewer = create(:resume_viewer, user_id: @user.id)

      res = Resume.get_info @resume
      expect(res["apply_count"]).to eq(2)
    end

    #测试admin resume 构造数据
    describe 'test get_resume_info' do
      before :each do
        @user = create(:user)
        @resume = create(:resume, user_id: @user.id)
        @hospital = create(:hospital)
        @job = create(:job)
        @education_experience = create(:education_experience, user_id: @user.id)
        @work_experience = create(:work_experience, user_id: @user.id)
        @expect_job = create(:expect_job, user_id: @user.id)
        @apply_record = create(:apply_record, user_id: @user.id, job_id: @job.id)
        @resume_viewer = create(:resume_viewer, user_id: @user.id, hospital_id: @hospital.id)
      end

      it 'test get_resume_info resume_id' do
        res = Resume.get_resume_info @resume.id
        expect(res[:id]).to eq(@resume.id)
        expect(res[:user]).to eq(@user)
      end
    end

    # 测试简历完整度
    describe 'test get_maturity' do
      before :each do
        @user = create(:user)
        @resume = create(:resume, user_id: @user.id)
        @education_experience = create(:education_experience, user_id: @user.id)
        @expect_job = create(:expect_job, user_id: @user.id)
      end

      it "no resume" do
        res = Resume.get_maturity 999
        expect(res).to eq(0)
      end

      it "test maturity = 100" do
        res = Resume.get_maturity @user.id
        expect(res).to eq(100)
      end

      it "test lack user" do
        @user.birthday = nil
        @user.save!

        res = Resume.get_maturity @user.id
        expect(res).to eq(75)
      end

      it "test incomplete user" do
        @user.birthday = nil
        @user.save!

        res = Resume.get_maturity @user.id
        expect(res).to eq(75)
      end

      it "test without education_experience" do
        @education_experience.destroy!

        res = Resume.get_maturity @user.id
        expect(res).to eq(75)
      end

      it "test without expect_job" do
        @expect_job.destroy!

        res = Resume.get_maturity @user.id
        expect(res).to eq(75)
      end

      # it "test lack of avatar" do
      #   @user.update_attributes(avatar: false)
      #
      #   puts '------------ava' + @user.avatar.to_s
      #
      #   res = Resume.get_maturity @user.id
      #   expect(res).to eq(75)
      # end

    end
end
