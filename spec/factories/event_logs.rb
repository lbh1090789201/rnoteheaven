FactoryGirl.define do
  factory :event_log do
    user_id 6
    show_name '测试日志'
    table 'Resume'
    obj_id 5
    object_name "简历"
    action '删除'
  end
end
