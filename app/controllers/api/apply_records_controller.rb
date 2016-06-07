class Api::ApplyRecordsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  #post to 应聘
  def create
    @apply_record = ApplyRecord.new apply_records_params
    @apply_record.user_id = current_user.id
    #....
    @apply_record.save
  end

  private
  def apply_records_params
    params.require(:apply_record).permit(:job_id)
  end

end
