include ValidationCodesHelper
class Webapp::MapController < ApplicationController
  before_filter :authenticate_user!, except: [:update_avatar]
  #个人中心
  def show
    restaurant = Restaurant.find_by(id: params[:id])
    @longitude = restaurant.longitude
    @latitude = restaurant.latitude
    puts '-------------------@longitude: ' + @longitude
    puts '-------------------@latitude:  ' + @latitude
  end

end




