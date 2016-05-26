module OrdersHelper
  #生成消费码
  def generate_consume_code
    array = ['0','1','2','3','4','5','6','7','8','9']

    code = ''
    (1..8).each do
      code += array[rand(10)]
    end

    order = Order.find_by(consume_code: code)

    if order
      return generate_consume_code
    else
      return code
    end
  end

  def generate_order_no
    array0 = ['1','2','3','4','5','6','7','8','9']

    code = array0[rand(9)]

    array = ['0','1','2','3','4','5','6','7','8','9']

    (1..15).each do
      code += array[rand(10)]
    end

    order = Order.find_by(order_no: code)

    if order
      return generate_order_no
    else
      return code
    end
  end

  # 未支付订单付款(支付订单)
  def pay(user_id, order, string)
    # if string == '账户余额不足，请充值！'
    #   render '/webapp/our'
    #   return
    # end
    order = Order.find_by(id: order.id)
    unless order
      return '订单不存在！'
    end
    unless order.status == 'unpaid'
      return '订单已支付！'
    end
    invitation_id = user_id
    unless invitation_id == order.invitation_id
      return '此订单不是你的订单，不能支付！'
    end

    invitation = User.find_by(id: order.invitation_id)
    if invitation.balance < order.order_amount
      return '账户余额不足，请充值！'
    end

    #自动生成消费码consume_code
    order.consume_code = generate_consume_code

    type = order.order_type
    if type == 'invited'
      order.status = 'waiting'
    else
      order.status = 'paid'
    end

    invitation.balance = invitation.balance - order.order_amount
    if invitation.save
      if order.save
        return
      else
        invitation.balance = invitation.balance + order.order_amount
        invitation.save
        return'支付失败！'
      end
    else
      return '账户扣款失败！'
    end
  end

  #取消未支付订单　
  #取消被拒绝订单
  #取消等待中订单
  def cancel(user_id, params)
    order = Order.find_by(id: params[:id])
    unless order
      return '订单不存在！'
    end
    unless order.invitation_id == user_id
      return '此订单不是你下的单，不能取消！'
    end

    if order.status != 'unpaid' && order.status != 'refused' && order.status != 'waiting'
      return '此订单不能取消！'
    end

    order.status = 'canceled'

    unless order.save
      return '取消订单失败！'
    end

    return
  end

  #拒绝邀约
  def refuse(user_id, params, string)
    order = Order.find_by(id: params[:id])
    unless order
      return '订单不存在！'
    end
    unless order.invited_id == user_id
      return '此订单邀约的不是你，不能拒绝！'
    end

    if order.status != 'waiting'
      return '此订单现在不在“等待中”，不能拒绝！'
    end

    order.status = 'refused'

    unless order.save
      return '拒绝邀约失败！'
    end

    return "已拒绝"
  end

  #同意邀约
  def agree(user_id, params)
    order = Order.find_by(id: params[:id])
    unless order
      return '订单不存在！'
    end
    unless order.invited_id == user_id
      return '此订单邀约的不是你，不能同意！'
    end

    if order.status != 'waiting'
      return '此订单现在不在“等待中”，不能同意！'
    end

    order.status = 'dating'

    unless order.save
      return  '拒绝邀约失败！'
    end

    return
  end

  #删除订单
  def delete(user_id, params)
    order = Order.find_by(id: params[:id])
    unless order
      return '订单不存在！'
    end

    unless order.invitation_id == user_id
      return '此订单不是你下的单，不能删除！'
    end

    if order.status != 'canceled' && order.status != 'ended'
      return '只能删除取消和结束的订单'
    end

    order.status = 'deleted'

    unless order.save
      return  '删除订单失败！'
    end

    return
  end

  #餐厅check_in
  def check_in(params)
    order = Order.find_by(consume_code:  params[:consume_code])
    unless order
      return '订单不存在！'
    end
    restaurant_id = params[:restaurant_id]
    unless order.restaurant_id == restaurant_id
      return '此订单不是此餐厅的单，不能在此餐厅消费！'
    end
    if order.status != 'paid' && order.status != 'dating'
      msg = ''
      case
        when 'unpaid'
          msg = '您的订单未支付，还不能再消费'
        when 'waiting'
          msg = '您邀约的食客还没有回应，还不能再消费'
        when 'refused'
          msg = '您邀约的食客已拒绝您的邀约，还不能再消费'
        when 'ended'
          msg = '此订单已消费，不能再消费'
        when 'canceled'
          msg = '此订单已取消，不能再消费'
        when 'deleted'
          msg = '此订单已删除，不能再消费'
      end
      return msg
    end

    order.status = 'ended'

    unless order.save
      return '订单消费失败！'
    end

    return
  end


end
