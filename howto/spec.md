<!-- 测试用例写法 -->
describe 'test get_maturity' do
  before :each do
    @user = create(:user)
    @resume = create(:resume, user_id: @user.id)
    @education_experience = create(:education_experience, user_id: @user.id)
    @expect_job = create(:expect_job, user_id: @user.id)
  end

  it "test maturity = 100" do
    res = Resume.get_maturity @user.id
    expect(res).to eq(100)
  end

end
