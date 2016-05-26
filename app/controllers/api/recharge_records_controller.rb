module Api
  class RechargeRecordsController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #账户充值
    def create
      rechargeRecord = RechargeRecord.new recharge_record_params
      rechargeRecord.recharge_time = Time.now
      rechargeRecord.get_ways_time = Time.now

      unless rechargeRecord.save
        puts '充值失败'
        render json: {
                   success: false,
                   errors: ['充值失败'],
               }, status: 403
        return
      end

      fcf = {
          id: rechargeRecord.id,
          recharge_ways: rechargeRecord.recharge_ways,
          recharge_money: rechargeRecord.recharge_money,
          recharge_time: rechargeRecord.recharge_time,
          get_ways_time: rechargeRecord.get_ways_time,
          user: User.find_by(id: rechargeRecord.user_id)
      }
      render json: {
                 success: true,
                 info: '充值成功',
                 data: fcf
             }, status: 200
    end

    def update

    end

    #删除充值记录
    def destroy
      rechargeRecord = RechargeRecord.find_by(id: params[:id])
      puts 'rechargeRecord => ' + rechargeRecord.to_json.to_s
      unless rechargeRecord
        render json: {
                   success: false,
                   info: '删除充值记录失败'
               }, status: 403
        return
      end
      if rechargeRecord.delete
        render json: {
                   success: true,
                   info: '删除充值记录成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '删除充值记录失败'
             }, status: 403
    end

    #获取充值记录列表
    def index
      rechargeRecords = RechargeRecord.where(user_id: params[:user_id])
      puts 'rechargeRecords => ' + rechargeRecords.to_json.to_s
      unless rechargeRecords
        render json: {
                   success: false,
                   info: '获取充值记录列表失败'
               }, status: 403
        return
      end
      render json: {
                 success: true,
                 info: '获取充值记录列表成功',
                 data: rechargeRecords
             }, status: 200
    end

    #获取充值记录详情
    def show
      rechargeRecord = RechargeRecord.find_by(id: params[:id])
      puts 'rechargeRecord => ' + rechargeRecord.to_json.to_s
      unless rechargeRecord
        render json: {
                   success: false,
                   info: '获取充值记录详情失败'
               }, status: 403
        return
      end
      render json: {
                 success: true,
                 info: '获取充值记录详情成功',
                 data: rechargeRecord
             }, status: 200
    end

    private
    def recharge_record_params
      params.permit(:recharge_ways, :recharge_money,
                    # :recharge_time, :get_ways_time,
                    :user_id )


      # belongs_to :user #充值账户
      # # t.string :recharge_ways   # 充值方式 :微信 (wechat)
      # # t.string :recharge_money   #金额
      # # t.datetime :recharge_time   #充值时间
      # # t.datetime :get_ways_time   #到帐时间

    end
  end
end
