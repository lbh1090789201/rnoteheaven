class Role < ActiveRecord::Base #用户角色
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def self.set_platinum user, res_name
    case res_name
    when 'jobs_manager'
      user.add_role :platinum, Job.first
    when 'resumes_manager'
      user.add_role :platinum, Resume.first
    when 'hospitals_manager'
      user.add_role :platinum, Hospital.first
    when 'fairs_manager'
      user.add_role :platinum, JobFair.first
    when 'vips_manager'
      user.add_role :platinum, Employer.first
    when 'acounts_manager'
      user.add_role :platinum, ApplyRecord.first
    end
  end

end
