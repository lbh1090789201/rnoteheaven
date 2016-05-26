include BdLbsHelper
module Api
  class RestaurantsController < ApiController
    #before_filter :authenticate_user_from_token!, except: [:forgot_password]
    # before_filter :authenticate_user!

    #上传餐厅信息
    def create
      restaurant = Restaurant.new(:name => restaurant_params[:name],
                                  :address => restaurant_params[:address],
                                  :longitude => restaurant_params[:longitude],
                                  :latitude => restaurant_params[:latitude],
                                  :province => restaurant_params[:province],
                                  :city => restaurant_params[:city],
                                  :region => restaurant_params[:region],
                                  :road => restaurant_params[:road],
                                  :tagging => restaurant_params[:tagging],
                                  :introduction => restaurant_params[:introduction],
                                  :telephone => restaurant_params[:telephone],
                                  :has_wifi => restaurant_params[:has_wifi],
                                  :has_parking => restaurant_params[:has_parking],
                                  :status => restaurant_params[:status],
                                  :image => restaurant_params[:image])
      if params[:file]
        restaurant.image = params[:file]
      end
      unless restaurant.save
        puts '餐厅信息上传失败'
        render json: {
                   success: false,
                   errors: ['餐厅信息上传失败'],
               }, status: 403
        return
      end
      fcf = {
          id: restaurant.id,
          name: restaurant.name,
          address: restaurant.address,
          longitude: restaurant.longitude,
          latitude: restaurant.latitude,
          province: restaurant.province,
          city: restaurant.city,
          region: restaurant.region,
          road: restaurant.road,
          tagging: restaurant.tagging,
          introduction: restaurant.introduction,
          telephone: restaurant.telephone,
          has_wifi: restaurant.has_wifi,
          has_parking: restaurant.has_parking,
          image: restaurant.image,
          status: restaurant.status
      }

      create_restaurant_on_lbs(restaurant)

      render json: {
                 success: true,
                 info: '餐厅信息上传成功',
                 data: fcf
             }, status: 200
    end

    def update
      restaurant = Restaurant.find_by(id: params[:id])
      unless restaurant
        render json: {
                   success: false,
                   info: '修改餐厅信息失败'
               }, status: 403
        return
      end
      need_update_lbs = false
      if restaurant.longitude != restaurant_params[:longitude] || restaurant.latitude != restaurant_params[:latitude]
        need_update_lbs = true
      end
      unless restaurant.update(:name => restaurant_params[:name],
                               :address => restaurant_params[:address],
                               :longitude => restaurant_params[:longitude],
                               :latitude => restaurant_params[:latitude],
                               :province => restaurant_params[:province],
                               :city => restaurant_params[:city],
                               :region => restaurant_params[:region],
                               :road => restaurant_params[:road],
                               :tagging => restaurant_params[:tagging],
                               :introduction => restaurant_params[:introduction],
                               :telephone => restaurant_params[:telephone],
                               :has_wifi => restaurant_params[:has_wifi],
                               :has_parking => restaurant_params[:has_parking],
                               :status => restaurant_params[:status],
                               :image => restaurant_params[:image])
        render json: {
                   success: false,
                   info: '修改餐厅信息失败'
               }, status: 403
        return
      end
      if params[:file]
        unless restaurant.update(:image => params[:file])
          render json: {
                     success: false,
                     info: '修改餐厅信息失败'
                 }, status: 403
          return
        end
      end
      fcf = {
          id: restaurant.id,
          name: restaurant.name,
          address: restaurant.address,
          longitude: restaurant.longitude,
          latitude: restaurant.latitude,
          province: restaurant.province,
          city: restaurant.city,
          region: restaurant.region,
          road: restaurant.road,
          tagging: restaurant.tagging,
          introduction: restaurant.introduction,
          telephone: restaurant.telephone,
          has_wifi: restaurant.has_wifi,
          has_parking: restaurant.has_parking,
          image: restaurant.image,
          status: restaurant.status
      }

      if need_update_lbs
        update_restaurant_on_lbs(restaurant)
      end

      render json: {
                 success: true,
                 info: '修改餐厅信息成功',
                 data: fcf
             }, status: 200
    end

    def destroy
      restaurant = Restaurant.find_by(id: params[:id])
      unless restaurant
        render json: {
                   success: false,
                   info: '餐厅信息删除失败'
               }, status: 403
      end
      if restaurant.delete
        render json: {
                   success: true,
                   info: '餐厅信息删除成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '餐厅信息删除失败'
             }, status: 403
    end

    #获取餐厅列表
    def index
      restaurants = []
      if params[:lng] != nil && params[:lat] != nil
        #待修改
      else
        restaurants = Restaurant.where(city: '深圳市')
      end
      puts 'restaurants => ' + restaurants.to_json.to_s
      unless restaurants
        render json: {
                   success: true,
                   info: '获取餐厅列表失败'
               }, status: 403
        return
      end
      render json: {
                 success: false,
                 info: '获取餐厅列表成功',
                 data: restaurants
             }, status: 200
    end

    #获取详情
    def show
      restaurant = Restaurant.find_by(id: params[:id])
      puts 'restaurant => ' + restaurant.to_json.to_s
      unless restaurant
        render json: {
                   success: true,
                   info: '获取餐厅信息失败'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '获取餐厅信息成功',
                 data: restaurant
             }, status: 403
    end

    private
    def restaurant_params
      params.permit(:name, :address,
                    :longitude, :latitude,
                    :province, :city, :region, :road,
                    :tagging,
                    :introduction,
                    :telephone,
                    :has_wifi, :has_parking,
                    :image, :status)

    end
  end
end
