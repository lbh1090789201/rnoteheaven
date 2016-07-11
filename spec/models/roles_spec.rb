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
      Role.set_platinum @user, 'resumes_manager'
      Role.set_platinum @user, 'hospitals_manager'

      res = @user.has_role? :resumes_manager
      res2 = @user.has_role? :hospitals_manager
      expect(res).to eq(true)
      expect(res2).to eq(true)
    end

    it "is test hospitals_manager" do
      user = Role.set_platinum @user, 'hospitals_manager'

      res = @user.has_role? :platinum
      res2 = @user.has_role? :hospitals_manager
      expect(res).to eq(true)
      expect(res2).to eq(true)
    end
    it "is test jobs_manager" do
      user = Role.set_platinum @user, 'jobs_manager'

      res = @user.has_role? :jobs_manager
      expect(res).to eq(true)
    end

    it "is test vips_manager" do
      user = Role.set_platinum @user, 'vips_manager'

      res = @user.has_role? :vips_manager
      expect(res).to eq(true)
    end

    it "is test acounts_manager" do
      user = Role.set_platinum @user, 'acounts_manager'

      res = @user.has_role? :acounts_manager
      expect(res).to eq(true)
    end

  end

  describe "test about roles" do
    before :each do
      @user = create(:user)
      @user.add_role :jobs_manager
      @user.add_role :resumes_manager
    end

    it "is test get_manager user" do
      res = Role.get_manager @user
      expect(res[0][:jobs_manager]).to eq(true)
      expect(res[0][:hospitals_manager]).to eq(false)
    end

    it "is test remove_all_roles user" do
      res = Role.remove_all_roles @user
      res2 = @user.has_role? :jobs_manager
      expect(res).to eq(true)
      expect(res2).to eq(false)
    end

  end


end