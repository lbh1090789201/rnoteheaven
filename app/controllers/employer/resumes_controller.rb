class Employer::ResumesController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
    hospital = Employer.get_hospital current_user.id
    jobs = Job.where(hospital_id: hospital.id)

    # 三个月内简历
    @apply_records = ApplyRecord.where("hospital_id = ? && recieve_at > ?",
                                        hospital.id, Time.now - 90.days).order("apply_at DESC")

    # 公开简历
    public_resumes = Resume.where(public: true).order("refresh_at DESC")
    @public_seekers = []
    public_resumes.each do |f|
      @public_seekers.push Resume.info(f.user_id)
    end

    # 按职位查看
    @jobs_by_position = []
    jobs.each do |f|
      @jobs_by_position.push Job.get_seekers(f.id)
    end
  end

  def show

  end
end


# 接口说明
# @apply_records 三个月内本医院的简历 类型： hash 数组

#@public_seekers 公开简历
# [{
#     "id": 2316,
#     "start_work_at": "2010",
#     "highest_degree": "本科",
#     "birthday": "2015-06-18T09:38:20.000Z",
#     "show_name": "3654",
#     "sex": "男",
#     "avatar": {
#         "url": null
#     },
#     "expect_job": "solider",
#     "age": 0,
#     "resume_id ": 49
# },……]

# @jobs_by_position 按职位查看 类型：hash 数组
# [{
#     "id": 2109,
#     "hospital_id": 2320,
#     "name": "护士",
#     "hospital_region": "MyString",
#     "has_new": false,
#     "seekers": [{
#         "id": 3336,
#         "start_work_at": "2010",
#         "highest_degree": "本科",
#         "birthday": "2015-06-18T12:04:00.000Z",
#         "show_name": "3654",
#         "sex": "男",
#         "avatar": {
#             "url": null
#         },
#         "expect_job": "高级护士",
#         "age": 0,
#         "resume_id ": 49,
#         "apply_at": "2016-05-18T18:04:53.000Z"
#     }, {
#         "id": 3337,
#         "start_work_at": null,
#         "highest_degree": null,
#         "birthday": "2012-09-21T12:04:00.000Z",
#         "show_name": "zahng",
#         "sex": null,
#         "avatar": {
#             "url": null
#         },
#         "expect_job": "高级护士",
#         "age": 3,
#         "resume_id ": 50,
#         "apply_at": "2016-05-18T18:04:53.000Z"
#     }]
# },……]
