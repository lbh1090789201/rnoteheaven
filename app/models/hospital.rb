class Hospital < ActiveRecord::Base
  has_many :jobs
  has_many :resume_views

  validates :introduction, length: { in: 4..45 }

end
