module Api
  class FoodPackagesController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #上传餐厅信息
    def create
      foodPackage = FoodPackage.new food_package_params
      # :restaurant_id => food_package_params[:restaurant_id],
      # :main_picture => food_package_params[:main_picture],
      # :second_picture => food_package_params[:second_picture],
      # :name => food_package_params[:name],
      # :use_number => food_package_params[:use_number],
      # :before_price => food_package_params[:before_price],
      # :discount_price => food_package_params[:discount_price],
      # :discount => food_package_params[:discount],
      # :is_refund => food_package_params[:is_refund],
      # :is_advance => food_package_params[:is_advance],
      # :sweet_tips => food_package_params[:sweet_tips],
      # :status => food_package_params[:status])
      if params[:main_picture]
        foodPackage.update(:main_picture => params[:main_picture])
      end
      if params[:second_picture]
        foodPackage.update(:second_picture => params[:second_picture])
      end
      unless foodPackage.save
        puts '套餐信息上传失败'
        render json: {
                   success: false,
                   errors: ['套餐信息上传失败'],
               }, status: 403
        return
      end
      fcf = {
          id: foodPackage.id,
          main_picture: foodPackage.main_picture,
          second_picture: foodPackage.second_picture,
          name: foodPackage.name,
          use_number: foodPackage.use_number,
          before_price: foodPackage.before_price,
          discount_price: foodPackage.discount_price,
          discount: foodPackage.discount,
          is_refund: foodPackage.is_refund,
          is_advance: foodPackage.is_advance,
          sweet_tips: foodPackage.sweet_tips,
          status: foodPackage.status
      }
      render json: {
                 success: true,
                 info: '套餐信息上传成功',
                 data: fcf
             }, status: 200
    end

    def update
      foodPackage = FoodPackage.find_by(id: params[:id])
      unless foodPackage
        render json: {
                   success: false,
                   info: '修改套餐信息失败'
               }, status: 403
        return
      end
      unless foodPackage.update(
          :restaurant_id => food_package_params[:restaurant_id],
          :main_picture => food_package_params[:main_picture],
          :second_picture => food_package_params[:second_picture],
          :name => food_package_params[:name],
          :use_number => food_package_params[:use_number],
          :before_price => food_package_params[:before_price],
          :discount_price => food_package_params[:discount_price],
          :discount => food_package_params[:discount],
          :is_refund => food_package_params[:is_refund],
          :is_advance => food_package_params[:is_advance],
          :sweet_tips => food_package_params[:sweet_tips],
          :status => food_package_params[:status])
        render json: {
                   success: false,
                   info: '修改套餐信息失败'
               }, status: 403
        return
      end

      if params[:main_picture]
        unless foodPackage.update(:main_picture => params[:main_picture])
          render json: {
                     success: false,
                     info: '修改套餐信息失败'
                 }, status: 403
          return
        end
      end
      if params[:second_picture]
        unless foodPackage.update(:second_picture => params[:second_picture])
          render json: {
                     success: false,
                     info: '修改套餐信息失败'
                 }, status: 403
          return
        end
      end
      fcf = {
          id: foodPackage.id,
          main_picture: foodPackage.main_picture,
          second_picture: foodPackage.second_picture,
          name: foodPackage.name,
          use_number: foodPackage.use_number,
          before_price: foodPackage.before_price,
          discount_price: foodPackage.discount_price,
          discount: foodPackage.discount,
          is_refund: foodPackage.is_refund,
          is_advance: foodPackage.is_advance,
          sweet_tips: foodPackage.sweet_tips,
          status: foodPackage.status
      }
      render json: {
                 success: true,
                 info: '修改套餐信息成功',
                 data: fcf
             }, status: 200
    end

    def destroy
      foodPackage = FoodPackage.find_by(id: params[:id])
      unless foodPackage
        render json: {
                   success: false,
                   info: '套餐信息删除失败'
               }, status: 403
        return
      end
      if foodPackage.delete
        render json: {
                   success: true,
                   info: '套餐信息删除成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '套餐信息删除失败'
             }, status: 403
    end

    #获取套餐列表
    def index
      foodPackages = FoodPackage.where(restaurant_id: params[:restaurant_id])
      puts 'foodPackages => ' + foodPackages.to_json.to_s
      unless foodPackages
        render json: {
                   success: true,
                   info: '获取餐厅的套餐列表失败'
               }, status: 403
        return
      end
      render json: {
                 success: false,
                 info: '获取餐厅的套餐列表成功',
                 data: foodPackages
             }, status: 200
    end

    #获取详情
    def show
      foodPackage = FoodPackage.find_by(id: params[:id])
      puts 'foodPackage => ' + foodPackage.to_json.to_s
      unless foodPackage
        render json: {
                   success: true,
                   info: '获取套餐详情失败'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '获取套餐详情成功',
                 data: foodPackage
             }, status: 403
    end

    private
    def food_package_params
      params.permit(:main_picture, :second_picture,
                    :name, :use_number,
                    :before_price, :discount_price, :discount,
                    :is_refund, :is_advance,
                    :sweet_tips,
                    :status, :restaurant_id)
      # t.string :main_picture #主图
      # t.string :second_picture #副图
      # t.string :name #名称
      # t.string :use_number #使用人数
      # t.float :before_price #原价格
      # t.float :discount_price #优惠价格
      # t.float :discount #折扣
      # t.string :is_refund #是否可退款
      # t.string :is_advance #是否需要预约
      # t.string :sweet_tips #温馨提示
      # t.string :status #状态  正常：normal　　挂起：stopping

    end
  end
end
