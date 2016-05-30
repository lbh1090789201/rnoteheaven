# Generated with RailsBricks
# Initial seed file to use with Devise User Model

User.create!(
    username: "test",
    show_name: "test",
    password: "123456",
    email: "admin@example.com",
    cellphone: "13888888778",
    sex: "男"
)


# Test ApplyRecord :tw

i = 1
while i < 2 do
    ApplyRecord.create! ({
      resume_id: 1,
      job_id: 1,
      user_id: 1,
      apply_at: "2016-5-26",
      resume_status: "筛选",
      recieve_at: "2016-5-27",
    })
  i += 1
end



# Test Job :tw
i = 1
while i < 3 do
    Job.create! ({
      name: "护士" + 'i',
      salary_range: "1000-6000",
      location: "深圳",
      job_desc: "很好啊",
      needed_number: 3,
      job_type: "IT",
      is_top: false,
      is_top_at: "2016-05-25 17:56:53",
    })
  i += 1
end

# Test UserInfo :tw
# i = 1
# while i < 5 do
#     UserInfo.create! ({
#     :user_id => i,
#     :main_picture => 'kkk',
#     :age => 'rand(66)',
#     :height => rand(999),
#     :mood => '13068649526',
#     :lover => '篮球',
#     :job => 'tw',
#     :favorite_place => 'tw',
#     :favorite_food => '海鲜',
#     :verification_status => '审核通过',
#     :unpass_reason => '照片不合法'
#     })
#   i += 1
# end

# test FavoriteJob bh

# Job.create! ({
#    name: "全职护士",
#    salary_range: "4000-6000",
#    location: "广州白云区"
# })
#
# i = 1
# while i < 5 do
#   FavoriteJob.create! ({
#     user_id: 1,
#     job_id: i,
#     collected_at: "2016-11-11"
#   })
#   i += 1
# end
