class FavoriteJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  # 是否应收藏？是：true;否：false
  def self.is_favor(uid, job_id)
    ! FavoriteJob.where(user_id: uid, job_id: job_id).blank?
  end

end
