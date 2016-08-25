class Employer::ResumesController < ApplicationController
  layout "employer"

  before_action do
    :require_employer!
    @vip_status = Employer.get_status current_user.id
  end

  def index
    check_vip = Employer.check_vip current_user.id
    hospital = Employer.get_hospital current_user.id
    jobs = Job.where(hospital_id: hospital.id).where.not(status: ['saved', 'fail', 'delete'])
    employer = Employer.find_by user_id: current_user.id
    may_receive = employer.may_receive


    # 三个月内简历
    @apply_records = ApplyRecord.where(hospital_id: hospital.id)
                                .order("recieve_at")
                                .limit(may_receive)
                                .where("recieve_at > ?", Time.now - 90.days)
                                .order("recieve_at DESC")


    # 公开简历
    public_resumes = Resume.where( "public = ? && maturity >= ?", true, 70)
                           .filter_no_freeze
                           .filter_is_block(hospital.id)
                           .order("refresh_at DESC")
    @public_seekers = []
    public_resumes.each do |f|
      @public_seekers.push Resume.info f.user_id, hospital.id
    end

    # 按职位查看
    last_apply_record= ApplyRecord.where(hospital_id: hospital.id)
                                .order("recieve_at")
                                .limit(may_receive)
                                .last

    recieve_at = last_apply_record ? last_apply_record.recieve_at : Time.now

    @jobs_by_position = []
    jobs.each do |f|
      @jobs_by_position.push Job.get_seekers(f.id, recieve_at)
    end
  end

  def show
    resume_id = params[:id]
    job_id = params[:job_id]

    hospital = Employer.get_hospital current_user.id
    resume = Resume.find resume_id

    @seeker = Resume.info resume.user_id, hospital.id
    @apply_record = ApplyRecord.select(:id, :job_name, :resume_status, :age, :job_name, :from).find_by(job_id: job_id, user_id: resume.user_id)
    # 简历预览
    @user = User.find resume.user_id
    @user_age = @user.birthday.nil? ? "保密" : ((Time.now - @user.birthday)/1.year).to_i
    @work_experiences = WorkExperience.where(:user_id => @user.id).order('started_at DESC')
    @education_experiences = EducationExperience.where(:user_id => @user.id).order('graduated_at DESC')
    @training_experiences = TrainingExperience.where(:user_id => @user.id).order('started_at DESC')
    @expect_job = ExpectJob.find_by_user_id(@user.id)
    @user.avatar_url.blank? ? @avatar = "avator.png" : @avatar = @user.avatar_url
    @certificates = Certificate.where(:user_id => @user.id)
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
#     "edu_num": 2,
#     "exp_num": 4,
#     "is_viewed": "is_viewed"
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
#         "apply_record_id" :1,
#         "from":"common",
#         "recieve_at": "2016-05-18T18:04:53.000Z",
#         "edu_num": 2,
#         "exp_num": 4,
#         "is_viewed": "is_viewed"
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
#         "apply_record_id" :2,
#         "from":"common",
#         "recieve_at": "2016-05-18T18:04:53.000Z"
#     }]
# },……]
