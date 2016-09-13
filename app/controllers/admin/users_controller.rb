class Admin::UsersController < AdminController
  before_action :require_acounts_manager!
  protect_from_forgery :except => [:create, :update, :destroy]

  def index
    if params[:search]
     @before_users = User.filter_by_role(['platinum', 'admin'])
                          .where('show_name LIKE ?', "%#{params[:show_name]}%")
                          .filter_by_manager(params[:manager])

     @after_users = User.filter_create_after(params[:time_from]).filter_create_before(params[:time_to])
     @users = (@before_users & @after_users)

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
    @log = EventLog.all.order('created_at DESC')
    @log = Kaminari.paginate_array(@log).page(params[:page]).per(15)
  end

  def  create
   return if is_repeate?# 判用户名重复

    id = User.last.id + 1

    new_platinum = {
      user_type: "platinum",
      username: params[:username],
      password: params[:password],
      show_name: params[:show_name],
      email: "platinum" + id.to_s + "@example.com"
    }
    scopes = params[:scopes].split(',')
    @user = User.create! new_platinum

    scopes.each do |f|
      Role.set_platinum @user, f
    end

    EventLog.create_log current_user.id, current_user.show_name, 'User', @user.id, "管理员", "增加"
    render json: {
      success: true,
      info: '创建管理员成功',
      user: @user
    }, status: 200
  end

  def edit
    return if is_repeate?# 判用户名重复
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
    return if is_repeate?# 判用户名重复
    user = User.find params[:id]
    user.show_name = params[:show_name]
    user.password = params[:password] if params[:password].present?
    user.save

    res = Role.remove_all_roles user
    scopes = params[:scopes].split(',')
    scopes.each do |f|
      Role.set_platinum user, f
    end

    EventLog.create_log current_user.id, current_user.show_name, 'User', user.id, "管理员", "修改"
    render json: {
      success: true,
      info: "更新管理员信息成功！",
      user: user
    }, status: 200
  end

  def destroy
    user = User.find params[:id]

    EventLog.create_log current_user.id, current_user.show_name, 'User', user.id, "管理员", "删除"
    if user.destroy
      render json: {
        success: true,
        info: '删除用户成功!'
      }, status: 200
    else
      render json: '删除用户失败。', status: 403
    end
  end

  private
    def is_repeate?
      if params[:id]
        my_user = User.find params[:id]
        return false if my_user.show_name == params[:show_name]
      end

      is_repeate = User.find_by(
        show_name: params[:show_name],
        user_type: ['admin', 'platinum']
      )

      is_occupied = User.find_by(
        username: params[:username],
        user_type: ['admin', 'platinum']
      )

      if is_occupied
          render json: {
            success: false,
            info: "此账号名称已被使用。"
          }, status: 403
          return true
      elsif is_repeate
        render json: {
          success: false,
          info: "此用户名已被使用。"
        }, status: 403
        return true
      end
    end

end
