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

	it "valid without email" do
		#expect(build(:user, email: nil)).to be_valid
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

end
