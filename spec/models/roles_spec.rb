require 'rails_helper'

RSpec.describe Role, type: :model do

  describe "test test set_platinum user string" do
    before :each do
      @user = create(:user)
    end

    it "is test jobs_manager" do
      user = Role.set_platinum @user, 'jobs_manager'

      res = @user.has_role? :platinum, Job.first
      expect(res).to eq(true)
    end

    it "is test resumes_manager" do
      user = Role.set_platinum @user, 'resumes_manager'

      res = @user.has_role? :platinum, Resume.first
      expect(res).to eq(true)
    end

    it "is test hospitals_manager" do
      user = Role.set_platinum @user, 'hospitals_manager'

      res = @user.has_role? :platinum, Job.first
      expect(res).to eq(true)
    end
    it "is test jobs_manager" do
      user = Role.set_platinum @user, 'jobs_manager'

      res = @user.has_role? :platinum, Job.first
      expect(res).to eq(true)
    end

    it "is test vips_manager" do
      user = Role.set_platinum @user, 'vips_manager'

      res = @user.has_role? :platinum, Employer.first
      expect(res).to eq(true)
    end

    it "is test acounts_manager" do
      user = Role.set_platinum @user, 'acounts_manager'

      res = @user.has_role? :platinum, ApplyRecord.first
      expect(res).to eq(true)
    end


  end

end
