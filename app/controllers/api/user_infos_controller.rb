module Api
  class UserInfosController < ApiController

    #上传用户详情信息
    def create

    end

    def update
      user = User.find_by(id: params[:user_id])
      unless user
        render json: {
                   success: false,
                   info: '上传用户详情信息失败'
               }, status: 403
        return
      end
      user_info = UserInfo.find_by(user_id: params[:user_id])
      if user_info == nil
        user_info = UserInfo.new user_info_params
        if params[:main_picture]
          user_info.user_info = params[:main_picture]
        end

        unless user_info.save
          puts '上传用户详情信息失败'
          render json: {
                     success: false,
                     errors: ['上传用户详情信息失败'],
                 }, status: 403
          return
        end
      else
        unless user_info.update user_info_params
          render json: {
                     success: false,
                     info: '上传用户详情信息失败'
                 }, status: 403
          return
        end
        if params[:main_picture]
          unless user_info.update(user_info => params[:main_picture])
            render json: {
                       success: false,
                       info: '上传用户详情信息失败'
                   }, status: 403
            return
          end
        end
      end
      fcf = {
          id: user_info.id,
          main_picture: user_info.main_picture,
          user_id: user_info.user_id,
          age: user_info.age,
          height: user_info.height,
          mood: user_info.mood,
          lover: user_info.lover,
          job: user_info.job,
          favorite_place: user_info.favorite_place,
          favorite_food: user_info.favorite_food
      }
      render json: {
                 success: true,
                 info: '上传用户详情信息成功',
                 data: fcf
             }, status: 200
    end

    def destroy
      user_info = nil
      if params[:id] != nil
        user_info = UserInfo.find_by(id: params[:id])
      elsif params[:user_id] != nil
        user_info = UserInfo.find_by(user_id: params[:user_id])
      end
      puts 'user_info => ' + user_info.to_json.to_s
      unless user_info != nil
        render json: {
                   success: false,
                   info: '删除用户详情信息失败'
               }, status: 403
        return
      end
      if user_info.delete
        render json: {
                   success: true,
                   info: '删除用户详情信息成功'
               }, status: 200
        return
      end
      render json: {
                 success: false,
                 info: '删除用户详情信息失败'
             }, status: 403
    end

    #获取用户详情信息列表
    def index

    end

    #获取详情
    def show
      user_info = nil
      if params[:id] != nil
        user_info = UserInfo.find_by(id: params[:id])
      elsif params[:user_id] != nil
        user_info = UserInfo.find_by(user_id: params[:user_id])
      end
      unless user_info
        render json: {
                   success: false,
                   info: '获取用户详情信息失败'
               }, status: 200
        return
      end
      puts 'user_info => ' + user_info.to_json.to_s
      f = {
          id: user_info.id,
          main_picture: user_info.main_picture,
          user_id: user_info.user_id,
          age: user_info.age,
          height: user_info.height,
          mood: user_info.mood,
          lover: user_info.lover,
          job: user_info.job,
          favorite_place: user_info.favorite_place,
          favorite_food: user_info.favorite_food
      }
      render json: {
                 success: true,
                 info: '获取用户详情信息成功',
                 data: f
             }, status: 403
    end

    private
    def user_info_params
      params.permit(:user_id,
                    # :main_picture,
                    :age, :height,
                    :mood, :lover, :job,
                    :favorite_place, :favorite_food)

      # t.string :main_picture #主图
      # t.string :age #年龄
      # t.float :height #身高
      # t.text :mood #心情
      # t.text :lover #欣赏的异性
      # t.string :job #职业
      # t.string :favorite_place #常出没地
      # t.string :favorite_food #喜爱美食
    end
  end
end
