class FavoriteJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  # 是否应收藏？是：true;否：false
  def self.is_favor(uid, job_id)
    ! FavoriteJob.where(user_id: uid, job_id: job_id).blank?
  end

  # employer 发布更新后
  def self.set_new jid
    favorite_jobs = FavoriteJob.where job_id: jid

    favorite_jobs.each do |f|
      f.has_new = true
      f.save
    end

    return favorite_jobs
  end

end
