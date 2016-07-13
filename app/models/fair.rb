class Fair < ActiveRecord::Base
  mount_uploader :banner, AvatarUploader

  scope :filter_begain_at, -> (begain_at) {
     where('begain_at > ?', begain_at) if begain_at.present?
   }

  scope :filter_end_at, -> (end_at) {
    where('begain_at < ?', end_at) if end_at.present?
  }

  scope :filter_by_name, -> (name) {
    where('name LIKE ?', "%#{name}%") if name.present?
  }

  scope :filter_by_status, -> (status){
    where(status: status) if status.present?
  }
end
