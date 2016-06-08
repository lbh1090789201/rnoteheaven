class ApplyRecord < ActiveRecord::Base
  def method
  end

  # 是否应聘过？是：true;否：false
  def self.is_applied(uid, job_id)
    ! ApplyRecord.where(user_id: uid, job_id: job_id).blank?
  end
end
