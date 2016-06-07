# Generated with RailsBricks
# Initial seed file to use with Devise User Model
#
# User.create!(
#     username: "test",
#     show_name: "test",
#     password: "123456",
#     email: "admin@example.com",
#     cellphone: "13888888778",
#     sex: "男"
# )


# Test ApplyRecord :tw

job_id = [1, 2, 3]
resume_status = ["筛选", "面试", "不合适"]
i = 0
while i < 3 do
    ApplyRecord.create! ({
      resume_id: 1,
      job_id: job_id[i],
      user_id: 1,
      apply_at: "2016-5-26",
      resume_status: resume_status[i],
      recieve_at: "2016-5-27",
    })
  i += 1
end


# Test FavoriteJob :bh

i = 1
while i < 4 do
  FavoriteJob.create!({
     user_id: 1,
     job_id: i,
     collected_at: "2016-05-25 17:56:53"
  })
  i += 1
end

#test Hospital :bh
name = ["南方医院", "中医院", "肿瘤医院"]
location = ["成都", "深圳", "成都"]
i = 0
while i<4 do
  Hospital.create! ({
                       name: name[i],
                       location: location[i],
                       introduction: "很好的医院"
                   })
  i += 1
end

#Test Job :bh
hospital_id = [1, 1, 2, 2, 3, 3, 3, 3]
name= ["护士", "护士", "护士", "护士", "全科医生", "儿科护士", "医生", "医生"]
salary_range = ["1000-6000", "1000-6000", "2000-5000", "2000-5000", "2000-5000", "2000-7000", "2000-7000", "2000-7000"]
location = ["深圳", "深圳", "成都", "成都", "成都", "成都", "成都", "深圳"]
i = 0
while i<8 do
  Job.create! ({
                       hospital_id: hospital_id[i],
                       name: name[i],
                       salary_range: salary_range[i],
                       location: location[i]
                   })
  i += 1
end

#Test ResumeView :bh
hospital_id = [1, 2, 3]
i = 0
while i<8 do
  ResumeView.create! ({
                       hospital_id: hospital_id[i],
                       user_id: 1,
                       view_at: "2016-05-10 02:10:00"
                   })
  i += 1
end

#Test WorkExperience :bh

  WorkExperience.create! ({
                       user_id: 1,
                       company: "北京互联网e+1",
                       position: "北京",
                       started_at: "2015-05-10",
                       left_time: "2016-05-10",
                       job_desc: "工作描述指在该职位上员工实际工作业务流程及授权范围。它是以“工作”为中心对岗位进行全面、系统、深入的说明，为工作评价、工作分类提供依据。在简历中的工作描述部分，则概称为工作经验的描述作经验有多有少，时间有长有短，但是最关键的是从你的工作描述中应该可以体现你的成长以及进步。"
                   })

#Test EducationExperience :bh

EducationExperience.create! ({
                                user_id: 1,
                                college: "某某大学",
                                education_degree: "本科",
                                entry_at: "2012-05-10",
                                graduated_at: "2015-05-10",
                                major: "计算机专业"
                            })



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
