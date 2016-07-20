require 'rails_helper'

RSpec.describe Hospital, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid to create ExpectJob" do
    hospital = build(:hospital)
    expect(hospital).to be_valid

  end

  # 模糊搜索测试
  describe 'test filter' do
    before :each do
      hospital = create :hospital
      hospital2 = create :hospital2
      hospital3 = create :hospital3
      hospital4 = create :hospital4
      hospital5 = create :hospital5
      hospital6 = create :hospital6
    end

    it 'test filter hospital name' do
      expect(Hospital.filter_hospital_name("深圳").size).to eq 3
    end

    it 'test filter location' do
      expect(Hospital.filter_location("成").size).to eq 2
    end

    it 'test filter hospital' do
      expect(Hospital.filter_location('成都').filter_hospital_name('第五').size).to eq 1
    end

    it "test filter_by_property" do
      expect(Hospital.filter_by_property('社').size).to eq(1)
    end

    it "test filter_create_before" do
      expect(Hospital.filter_create_before('2014-11-10 11:11:11').size).to eq(6)
    end

    it "test filter_create_after" do
      expect(Hospital.filter_create_after('2016-11-10 11:11:11').size).to eq(6)
    end

    it "test filter_contact_person" do
      expect(Hospital.filter_contact_person("李某某").size).to eq(2)
    end

    it "test filter_contact_person" do
      expect(Hospital.filter_contact_person("某某").size).to eq(6)
    end

  end

  # get_info方法测试
  describe "test get_info" do
    before :each do
      @user = create(:user)
      @hospital = create(:hospital)
      @plan = create(:plan)
      @employer = create(:employer, user_id: @user.id, hospital_id: @hospital.id, plan_id: @plan.id)
    end

    it "test hospita_name" do
      hospitals = Hospital.where(id: @hospital.id)
      hospital_info = Hospital.get_info hospitals
      expect(hospital_info[0][:name]).to eq(@hospital.name)
    end

    it "test vip_id" do
      hospitals = Hospital.where(id: @hospital.id)
      hospital_info = Hospital.get_info hospitals
      expect(hospital_info[0][:vip_id]).to eq(@plan.id)
    end
  end



end
