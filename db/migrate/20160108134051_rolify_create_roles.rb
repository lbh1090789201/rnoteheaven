class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])

    ['admin', #   admin, 系统管理员
     'gold', # 客户管理员
     'silver', # 客户经理
     'copper', # 普通客户
     'pending', # new people that are not yet confirmed in a role - default role assignment

    ].each do |role_name|
      Role.create! name: role_name
    end

  end
end
