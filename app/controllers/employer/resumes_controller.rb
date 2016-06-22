class Employer::ResumesController < ApplicationController
  before_action :require_employer!
  # before_action :require_vip!
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

    puts '-----------' + @jobs_by_position.to_json.to_s
  end

  def show
    resume_id = params[:id]
    job_id = params[:job_id]

    resume = Resume.find resume_id
    @seeker = Resume.info resume.user_id
    @apply_record = ApplyRecord.select(:id, :job_name).find_by(job_id: job_id, user_id: resume.user_id)

    # 简历预览
    @user = User.find resume.user_id
    @work_experiences = WorkExperience.where(:user_id => @user.id)
    @education_experiences = EducationExperience.where(:user_id => @user.id)
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @user.avatar_url.blank? ? @avatar = "avator2.png" : @avatar = @user.avatar_url
    @certificates = Certificate.where(:user_id => @user.id)

    # puts "------"+@user.to_json.to_s
  end
end


# 接口说明
# @apply_records 三个月内本医院的简历 类型： json 数组

#@public_seekers 公开简历 类型：json 数组
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

# @jobs_by_position 按职位查看 类型：json 数组
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
#         "from":"common",
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
#         "from":"common",
#         "apply_at": "2016-05-18T18:04:53.000Z"
#     }]
# },……]
