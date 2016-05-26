include ValidationCodesHelper
class Webapp::OurController < ApplicationController
  before_filter :authenticate_user!, except: [:update_avatar, :password_validate,:passwordChange]
  #个人中心
  def show
    @user_id = current_user.id
    @user = User.find_by(id: @user_id)
    puts '===========our_id:' + @user_id.to_s
    user_info =  UserInfo.find_by(user_id: @user_id)
    @userInfo = user_info
    unless user_info
      user_info = UserInfo.new
      user_info.user_id = @user_id
      user_info.save
      @userInfo = user_info
    end
    @user_info_id = @userInfo.id
    @sex = ''
    if @user.sex
      if @user.sex == 0
        @sex = '女'
      else
        @sex = '男'
      end
    end
  end

  #我的钱包
  def wallet
    @user_id = current_user.id
    #用户信息
    @wallet = User.find_by(id: @user_id)
    #充值记录
    @rechargeRecords = RechargeRecord.where(user_id: @user_id)
  end

  #安全设置
  def safeSetting
    @user_id = current_user.id
    user = User.find_by(id: @user_id)
    @is_transaction_password=''
    if user.transaction_password == nil || user.transaction_password == ''
      @is_transaction_password='未设置'
    end
    if user.cellphone.index('0') != nil && user.cellphone.index('0') == 0
      @is_cellphone='未绑定'
    else
      @is_cellphone='已绑定'+ user.cellphone[0..2] + '****' + user.cellphone[7..-1]
    end
    #进入安全设置页面不需要其它数据
  end

  #帮助与反馈
  def helpAndResponse
    @user_id = current_user.id
  end

  #充值
  def rechargeView
    @user_id = current_user.id
    #进入充值页面不需要其它数据
  end

  #绑定电话
  def bindingView
    @user_id = current_user.id
    #进入绑定电话页面不需要其它数据
  end

  #视频管理
  def videoManager
    # @userInfo = UserInfo.find_by(user_id :params[:user_id])
  end

  #支付密码管理
  def transactionPasswordManager
    @user_id = current_user.id

    user = User.find_by(id: @user_id)
    @is_transaction_password=true
    if user.transaction_password == nil || user.transaction_password == ''
      @is_transaction_password=false
    end

    #进入支付密码管理页面不需要其它数据
  end

  #设置支付密码
  def setPassword
    @user_id = current_user.id
    #进入设置支付密码页面不需要其它数据
  end

  #忘记支付密码
  def transactionPasswordFind
    #进入忘记支付密码页面不需要其它数据
  end

  #----------------------下面为提交接口------------------------#

  def update_avatar
    user_id = params[:our_id]
    user = User.find(user_id)
    unless user
      msg = '此用户不存在'
    end
    unless params[:addAvatar]
      msg = '不存在更新的头像'
    end
    user.avatar = params[:addAvatar]
    unless user.save
      msg = '保存失败'
    end
    redirect_to webapp_our_path(user_id)
  end

  def update_video
    user_id = params[:our_id]
    user = User.find(user_id)
    unless user
      msg = '此用户不存在'
    end
    unless params[:main_video]
      msg = '不存在更新的视频'
    end
    user.main_video = params[:main_video]
    unless user.save
      msg = '保存失败'
    end
    redirect_to webapp_our_path(user_id)
  end

  #修改支付密码
  def passwordChange
    puts 'cccccccccccccccccccccccc'+params[:passwordBefore].to_json.to_s
    user = User.find_by(id: params[:user_id])
    puts 'cccccccccccccccccccccccc'+user.to_json.to_s

    if params[:passwordBefore] == user.transaction_password
      render :js=>'alert("密码修改成功");$("form").submit();'
    else
      render :js=>'alert("原密码输入错误");$("input").attr("value","");'
    end
  end
#验证支付密码
  def password_validate
    user_id = params[:our_id]
    user = User.find_by(id: user_id)
    transaction_password = user.transaction_password
    input_password = params[:password]
    # invitation = User.find_by(id: invitation_id)
    # foodPackage = FoodPackage.find_by(id:params[:food_package_id])
    # money = foodPackage.discount_price
    # order = Order.new
    puts 'transaction_password----------------------'+transaction_password.to_json.to_s
    puts 'input_password----------------------'+input_password.to_json.to_s
    if transaction_password == input_password
      render json:{status:'success'}

    else

      render json:{status:'failed'}

    end
    # puts "success"
    #
    #   respond_to do |format|
    #   if transaction_password == input_password
    #     format.json do
    #       render({json:user, status:200})
    #     end
    #     format.html do
    #       render({nothing:true})
    #     end
    #   end

    # end



  end

  #删除相册图片(多张)
  def delete_photos
    user_id = params[:id]
    ids = params[:ids]
    ids.each do |user_albumn_id|
      userAlbumn = UserAlbumn.find(user_albumn_id)
      unless userAlbumn
        render json: {
                   success: false,
                   info: '删除相册图片失败'
               }, status: 403
        return
      end
      if userAlbumn.delete
        render json: {
                   success: true,
                   info: '删除相册图片成功'
               }, status: 200
        return
      end
    end
    render json: {
               success: false,
               info: '删除相册图片失败'
           }, status: 403
    redirect_to webapp_our_path(user_id)
  end

  #发送短信
  def send_vcode
    #创建vcode并调用短信网关发送vcode
    create_vcode(validation_code_params)
  end

  #充值
  def recharge
    #调用微信支付
  end

  #绑定电话
  def binding_cellphone
    user_id = :params[:user_id]
    cellphone = :params[:cellphone]
    vcode = :params[:vcode]
    #检验手机号与验证码是否匹配
    unless ValidationCode.verify_vcode_effective? cellphone, vcode
      render json: {
                 success:false,
                 info:'验证码错误'
             }, status: 403
      return
    end
    user = User.find(user_id)
    unless user
      render json: {
                 success:false,
                 info:'数据错误'
             }, status: 403
      return
    end
    user.cellphone = cellphone
    unless user.update
      render json: {
                 success: false,
                 info: '绑定电话失败'
             }, status: 403
      return
    end
    #webapp_restaurants GET /webapp/restaurants(.:format) webapp/restaurants#index
    redirect_to '/webapp/restaurants?'
  end

  #更换视频
  def update_video
    user_id = params[:user_id]
    user = User.friendly.find(user_id)
    userAlbumn = UserAlbumn.friendly.find(user_id)
    if user && userAlbumn
      unless userAlbumn.update(
                       :video => order_params[:video])
        render json: {
                   success: true,
                   info: '更换视频成功',
                   data: userAlbumn
               }, status: 200
      else
        render json: {
                   success: true,
                   info: '更换视频失败'
               }, status: 403

      end
    else
      render json: {
                 success: true,
                 info: '更换视频失败，该用户不存在'
             }, status: 403
    end
  end

  #登出
  def logout

  end

  #设置支付密码
  def transaction_password_new

  end

  #忘记支付密码
  def transaction_password_update

  end

  private
  def validation_code_params
    params.permit(
        :cellphone)
  end

end




