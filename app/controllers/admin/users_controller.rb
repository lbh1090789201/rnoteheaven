class Admin::UsersController < AdminController
  before_action :require_acounts_manager!
  layout 'admin'
  protect_from_forgery :except => [:create, :update, :destroy]
  def index
    if params[:search]
      @users = User.filter_create_before(params[:time_to])
                   .filter_create_after(params[:time_from])
                   .where('show_name LIKE ?', "%#{params[:show_name]}%")
                   .filter_by_role(['platinum', 'admin'])
                   .filter_by_manager(params[:manager])

      render json: {
        success: true,
        info: '搜索成功',
        users: @users
      }, status: 200
    else
      @users = User.filter_by_role(['platinum', 'admin'])
    end
  end

  def record
  end

  def  create
    id = User.last.id + 1

    new_platinum = {
      user_type: "platinum",
      username: "admin" + id.to_s,
      password: params[:password],
      show_name: params[:show_name],
      email: "platinum" + id.to_s + "@example.com"
    }
    scopes = params[:scopes].split(',')
    @user = User.create! new_platinum

    scopes.each do |f|
      Role.set_platinum @user, f
    end

    render json: {
      success: true,
      info: '创建管理员成功',
      user: @user
    }, status: 200
  end

  def edit
    user = User.find params[:id]

    res = Role.get_manager user
    managers = res[0]
    scopes = res[1]

    render json: {
      success:true,
      info: '获取角色信息成功',
      checkValues: managers,
      scopes: scopes
    }, status: 200
  end

  def update
    user = User.find params[:id]
    user.show_name = params[:show_name]
    user.password = params[:password] if params[:password].present?
    user.save

    res = Role.remove_all_roles user
    scopes = params[:scopes].split(',')
    scopes.each do |f|
      Role.set_platinum user, f
    end

    render json: {
      success: true,
      info: "更新管理员信息成功！",
      user: user
    }, status: 200
  end

  def destroy
    user = User.find params[:id]

    if user.destroy
      render json: {
        success: true,
        info: '删除用户成功!'
      }, status: 200
    else
      render json: '删除用户失败。', status: 403
    end
  end

end
