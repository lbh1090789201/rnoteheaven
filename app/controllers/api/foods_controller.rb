module Api
  class FoodsController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #上传餐厅信息
    def create
      food = Food.new(
          :json_name => params[:food_names].to_json,
          :remark => food_params[:remark],
          :food_package_id => food_params[:food_package_id])
      unless food.save
        puts '菜品信息上传失败'
        render json: {
                   success: false,
                   errors: ['菜品信息上传失败'],
               }, status: 403
        return
      end
      fcf = {
          id: food.id,
          main_picture: food.food_package_id,
          second_picture: food.remark,
          food_names: params[:food_names]
      }
      render json: {
                 success: true,
                 info: '菜品信息上传成功',
                 data: fcf
             }, status: 200
    end

    def update
      food = Food.find_by(id: params[:id])
      unless food
        render json: {
                   success: false,
                   info: '修改菜品信息失败'
               }, status: 403
        return
      end
      unless food.update(
          :json_name => params[:food_names].to_json.to_s,
          :remark => food_params[:remark],
          :food_package_id => food_params[:food_package_id])
        render json: {
                   success: false,
                   info: '修改菜品信息失败'
               }, status: 403
        return
      end
      fcf = {
          id: food.id,
          main_picture: food.food_package_id,
          second_picture: food.remark,
          food_names: params[:food_names]
      }
      render json: {
                 success: true,
                 info: '修改菜品信息成功',
                 data: fcf
             }, status: 200
    end

    def destroy
      food = Food.find_by(id: params[:id])
      puts 'food => ' + food.to_json.to_s
      unless food
        render json: {
                   success: false,
                   info: '菜品信息删除失败'
               }, status: 403
        return
      end
      if food.delete
        render json: {
                   success: true,
                   info: '菜品信息删除成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '菜品信息删除失败'
             }, status: 403
    end

    #获取菜品列表
    def index
      foods = Food.where(food_package_id: params[:food_package_id])
      puts 'foods => ' + foods.to_json.to_s
      unless foods
        render json: {
                   success: false,
                   info: '获取餐厅的菜品列表失败'
               }, status: 403
        return
      end
      fs = []
      foods.each do |food|
        f = {
            id: food.id,
            food_package_id: food.food_package_id,
            food_names: JSON.parse(food.json_name),
            remark: food.remark,
            created_at: food.created_at,
            updated_at: food.updated_at
        }
        fs.push(f)
      end
      render json: {
                 success: true,
                 info: '获取餐厅的菜品列表成功',
                 data: fs
             }, status: 200
    end

    #获取详情
    def show
      food = Food.find_by(id: params[:id])
      puts 'food => ' + food.to_json.to_s
      unless food
        render json: {
                   success: false,
                   info: '获取菜品详情失败'
               }, status: 200
        return
      end
      f = {
          id: food.id,
          food_package_id: food.food_package_id,
          food_names: JSON.parse(food.json_name),
          remark: food.remark,
          created_at: food.created_at,
          updated_at: food.updated_at
      }
      render json: {
                 success: true,
                 info: '获取菜品详情成功',
                 data: f
             }, status: 403
    end

    private
    def food_params
      params.permit(:food_names, :remark, :food_package_id)

      # t.string :json_name #菜名：json_name
      # t.string :remark #备注：remark

    end
  end
end
