module Api
  class OrdersController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #下单
    def create
      order = Order.new order_params

      restaurant = Restaurant.find_by(id: order_params[:restaurant_id])
      foodPackage = FoodPackage.find_by(id: order_params[:food_package_id])
      invitation = User.find_by(id: order_params[:invited_id])

      unless restaurant || foodPackage || invitation
        render json: {
                   success: false,
                   info: '下单失败'
               }, status: 403
        return
      end

      money = foodPackage.discount_price #优惠价格
      order.order_amount = money.to_f
      order.old_amount = foodPackage.before_price.to_f
      type = params[:order_type]
      if type == 'invited'
        order.order_type = 'invited'
        #被邀请人
        invited = User.find(params[:invited_id])
        if invited
          order.invited_id = invited.id
        else
          render json: {
                     success: false,
                     info: '被邀请人不存在，请重新选择！'
                 }, status: 403
          return
        end
      else
        order.order_type = 'own_eating'
      end
      if invitation.balance < money
        order.status = 'unpaid'#未支付
        msg = '账户余额不足，请充值！'
      else
        #自动生成消费码consume_code
        order.consume_code = generate_consume_code
        if type == 'invited'
          order.status = 'waiting'#等待中
        else
          order.status = 'paid'#自己吃的订单已支付
        end
        msg = '下单成功'
      end

      invitation.balance = invitation.balance - money
      unless invitation.save
        render json: {
                   success: false,
                   info: '扣款失败！'
               }, status: 403
        return
      end
      unless order.save
        puts '下单失败'
        invitation.balance = invitation.balance + money
        invitation.save
        render json: {
                   success: false,
                   errors: ['下单失败'],
               }, status: 403
        return
      end
      fcf = {
          id: order.id,
          restaurant_id: order.restaurant_id,
          food_package_id: order.food_package_id,
          invited_id: order.invited_id,
          invitation_id: order.invitation_id,
          self_introduction: order.self_introduction,
          order_amount: order.order_amount,
          old_amount:order.old_amount,
          status: order.status,
          created_at: order.created_at,
          updated_at: order.updated_at,
          consume_code: nil,
          handle_date: nil,
          result: nil
      }
      render json: {
                 success: true,
                 info: msg,
                 data: fcf
             }, status: 200
    end

    #修改订单
    def update
      order = Order.find_by(id: params[:id])
      unless order
        render json: {
                   success: false,
                   info: '修改菜品信息失败'
               }, status: 403
        return
      end
      restaurant = Restaurant.find_by(id: order_params[:restaurant_id])
      foodPackage = FoodPackage.find_by(id: order_params[:food_package_id])
      invitation = User.find_by(id: order_params[:invited_id])

      unless (restaurant && foodPackage && invitation)
        render json: {
                   success: false,
                   info: '下单失败'
               }, status: 403
        return
      end

      type = params[:order_type]
      if type == 'invited'
        #被邀请人
        invited = User.find(params[:invited_id])
        if invited
          order.invited_id = invited.id
        else
          render json: {
                     success: false,
                     info: '被邀请人不存在，请重新选择！'
                 }, status: 403
          return
        end
      end

      if !order.consume_code || order.consume_code.length != 10
        order.consume_code = generate_consume_code
      end

      unless order.update(
          :restaurant_id => order_params[:restaurant_id],
          :food_package_id => order_params[:food_package_id],
          :invitation_id => order_params[:invitation_id],
          :self_introduction => order_params[:self_introduction],
          :order_amount => order_params[:order_amount],
          :old_amount => order[:old_amount],
          :status => params[:status],
          :created_at => params[:created_at],
          :updated_at => params[:updated_at],
          :handle_date => params[:handle_date],
          :result => params[:result])
        render json: {
                   success: false,
                   info: '修改订单失败'
               }, status: 403
        return
      end
      fcf = {
          id: order.id,
          restaurant_id: order.restaurant_id,
          food_package_id: order.food_package_id,
          invited_id: order.invited_id,
          invitation_id: order.invitation_id,
          self_introduction: order.self_introduction,
          order_amount: order.order_amount,
          old_amount:order.old_amount,
          status: order.status,
          created_at: order.created_at,
          updated_at: order.updated_at,
          consume_code: order.consume_code,
          handle_date: order.handle_date,
          result: order.result
      }
      render json: {
                 success: true,
                 info: '修改订单成功',
                 data: fcf
             }, status: 200
    end

    #删除订单
    def destroy
      order = Order.find_by(id: params[:id])
      puts 'order => ' + order.to_json.to_s
      unless order
        render json: {
                   success: false,
                   info: '删除订单失败'
               }, status: 403
        return
      end
      if order.delete
        render json: {
                   success: true,
                   info: '删除订单成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '删除订单失败'
             }, status: 403
    end

    #获取订单列表
    def index
      invited_orders = Order.where(invited_id: params[:invited_id])
      invitation_orders = Order.where(invited_id: params[:invitation_id])
      puts 'invited_orders => ' + invited_orders.to_json.to_s
      puts 'invitation_orders => ' + invitation_orders.to_json.to_s
      unless (invited_orders && invitation_orders)
        render json: {
                   success: false,
                   info: '获取订单列表失败'
               }, status: 403
        return
      end
      orders = {
          invited_orders: invited_orders,
          invitation_orders: invitation_orders
      }
      render json: {
                 success: true,
                 info: '获取订单列表成功',
                 data: orders
             }, status: 200
    end

    #获取详情
    def show
      order = Order.find_by(id: params[:id])
      puts 'order => ' + order.to_json.to_s
      unless order
        render json: {
                   success: false,
                   info: '获取菜品详情失败'
               }, status: 200
        return
      end
      render json: {
                 success: true,
                 info: '获取菜品详情成功',
                 data: order
             }, status: 403
    end

    private
    def order_params
      params.permit(:restaurant_id, :food_package_id,
                    # :invited_id,
                    :invitation_id,
                    :self_introduction,
                    :invited_id,
                    :order_type,
                    :order_no,
                    :order_amount,
                    :old_amount
                    # :order
                    # :status,
                    # :consume_code,
                    # :created_at,:updated_at,
                    # :handle_date, :result,
                    )

      # t.references :restaurant #餐厅
      # t.references :food_packages #套餐
      #
      # t.integer :invited_id #被邀请人编号：invited_id -> user_id
      # t.integer :invitation_id #邀请人编号：invitation_id -> user_id
      #
      # t.string :self_introduction #邀请人自我介绍：self_introduction
      # t.string :status #订单状态： 未支付unpaid等待中waiting 约会中dating 已结束ended 被拒绝 refused 已取消 canceled
      # t.string :consume_code #消费码： 
      # t.datetime :created_at #创建时间:created_at
      # t.datetime :updated_at #最新修改时间:updated_at
      # t.datetime :handle_date #处理时间：handle_date
      # t.string :result #被邀请人处理结果：invitee_result
      # t.string :order_amount #订单金额：order_amount

    end
  end
end
