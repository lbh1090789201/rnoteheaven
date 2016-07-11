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

end
