FactoryGirl.define do

  #搜索页面虚构数据
  factory :hospital, :class => 'Hospital' do
    name "深圳第一医院"
    scale "10~20人"
    property "社区医院"
    industry "医疗"
    location "广东省深圳市宝安区第二人民医院"
    introduction "我是医院介绍"
    region "广东省"
  end

  factory :hospital2, :class => 'Hospital' do
    name "深圳第二医院"
    scale "MyString"
    property "MyString"
    location "深圳"
    introduction "MyString"
    region "MyString"
  end

  factory :hospital3, :class => 'Hospital' do
    name "深圳第三医院"
    scale "MyString"
    property "MyString"
    location "深圳"
    introduction "MyString"
    region "MyString"
  end

  factory :hospital4, :class => 'Hospital' do
    name "成都第四医院"
    scale "MyString"
    property "MyString"
    location "成都"
    introduction "MyString"
    region "MyString"
  end

  factory :hospital5, :class => 'Hospital' do
    name "成都第五医院"
    scale "MyString"
    property "MyString"
    location "成都"
    introduction "MyString"
    region "MyString"
  end

  factory :hospital6, :class => 'Hospital' do
    name "成都第一医院"
    scale "MyString"
    property "MyString"
    location "成都"
    introduction "MyString"
    region "MyString"
  end

end
