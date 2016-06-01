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
      expect(Hospital.filter_location("成").size).to eq 3
    end

    it 'test filter hospital' do
      expect(Hospital.filter_location('成都').filter_hospital_name('第五').size).to eq 1
    end

  end



end
