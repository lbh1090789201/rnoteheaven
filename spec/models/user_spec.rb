require 'rails_helper'

RSpec.describe User, :type => :model do
	it "valid with a cellphone, password" do
		expect(build(:user)).to be_valid
  end

  #don't know how to create a user without cellphone
	it "invalid without cellphone" do
		#expect(build(:user, cellphone: nil)).to_not be_valid
  end

	it "invalid with reduplication cellphone" do
		user = create(:user, cellphone: "13076016866")
		user2 = build(:user, cellphone: "13076016866")
		expect(user2).to_not be_valid
	end

	it "not valid without email" do
		expect(build(:user, email: nil)).to_not be_valid
	end

	#don't know how to create a user without cellphone
	it "invalid with reduplication email" do
		user = create(:user, email:"email@example.com")
		user2 = build(:user, email:"email@example.com")
		expect(user2).to_not be_valid
  end

  it 'invalid with reduplication show_name ' do
    user = create(:user, show_name: "张三")
    user2 = build(:user, show_name: "张三")
    expect(user2).to_not be_valid
  end

	it 'valid with start_work_at, location, seeking_job, highest_degree, birthday' do
		expect(create(:user)).to be_valid
	end

	it 'valid with test' do
		expect(create(:user2)).to be_valid
	end

	describe "test filter" do
		before :each do
			@user = create(:user, created_at: Time.now - 3.days, user_type: "gold")
			@user2 = create(:user2, created_at: Time.now - 1.days, user_type: "gold")
		end

		it "test filter_create_after" do
			res = User.filter_create_after Time.now - 2.days
			expect(res.length).to eq(1)
		end

		it "test filter_create_before" do
			res = User.filter_create_before Time.now
			expect(res.length).to eq(2)
		end

		it "test filter_by_role" do
			res = User.filter_by_role "gold"
			expect(res.length).to eq(2)
		end

		it "test filter_by_manager" do
			@user.add_role :jobs_manager

			res = User.filter_by_manager 'jobs_manager'
			expect(res[0]).to eq(@user)
		end

	end

end
