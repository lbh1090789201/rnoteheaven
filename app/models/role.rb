class Role < ActiveRecord::Base #用户角色
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def self.set_platinum user, manager
    user.add_role :platinum

    case manager
    when 'jobs_manager'
      user.add_role :jobs_manager
    when 'resumes_manager'
      user.add_role :resumes_manager
    when 'hospitals_manager'
      user.add_role :hospitals_manager
    when 'fairs_manager'
      user.add_role :fairs_manager
    when 'vips_manager'
      user.add_role :vips_manager
    when 'acounts_manager'
      user.add_role :acounts_manager
    end
  end

  def self.get_manager user
    managers = {}
    scopes = []
    roles = [:jobs_manager, :resumes_manager, :hospitals_manager,
             :fairs_manager, :vips_manager, :acounts_manager]

    roles.each do |f|
      res = user.has_role? f
      managers[f] =  res
      scopes.push f.to_s if res
    end

    return [managers, scopes]
  end

  def self.remove_all_roles user
    roles = [:jobs_manager, :resumes_manager, :hospitals_manager,
             :fairs_manager, :vips_manager, :acounts_manager]

    roles.each do |f|
      user.remove_role f
    end

    return true
  end

  # 校检用户类型
  def self.checkUser user
    hospital = Hospital.find_by contact_number: user.cellphone
    if hospital
      if user.user_type == "gold"
        return user
      else
        user.user_type = "gold"
        user.save
        user.add_role :gold

        employer = Employer.find_by hospital_id: hospital.id
        employer.user_id = user.id
        employer.save

        return user
      end
    else
      if user.user_type == "copper"
        return user
      else
        user.user_type = "copper"
        user.save
        user.remove_role :gold

        return user
      end
    end
  end

end
