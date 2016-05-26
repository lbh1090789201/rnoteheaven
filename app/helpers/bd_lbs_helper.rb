require 'json'
module BdLbsHelper
  #计算距离
  def rad(d)
    return d.to_f * Math::PI / 180.0
  end

  def distanceByLatLon(lat1, lon1, lat2, lon2)
    earth_radius = 6378.137
    radLat1 = rad(lat1)
    radLat2 = rad(lat2)
    a = radLat1 - radLat2
    b = rad(lon1) - rad(lon2)
    s = 2 * Math.asin(Math.sqrt((Math.sin(a / 2))**2 + Math.cos(radLat1) * Math.cos(radLat2) * (Math.sin(b / 2))**2))
    s = s * earth_radius
    s*=1000
    s = format("%.2f",s).to_f
    return s
  end

  #创建表
  def create_lbs_table(type, cn_table_name)
    table_name = cn_table_name
    if Rails.env != "production"
      table_name = cn_table_name + '测试'
    end
    url = 'http://api.map.baidu.com/geodata/v3/geotable/create'
    post_data = {
        name:   table_name,  	# geotable的中文名称
        geotype:          1, #geotable持有数据的类型 必选 1：点；2：线；3：面。默认为1（当前不支持“线”）
        is_published:     1,	# 是否发布到检索 必选 0：未自动发布到云检索， 1：自动发布到云检索；
        ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
    }
    # puts post_data.to_s
    response = HTTParty.post(url, :body => post_data)
    data = JSON.parse(response.body)
    # puts data.to_s
    if data['status'] == 0 #创建成功
      return data['id']
    elsif data['status'] == 1001 #表的name重复 表已存在
      #获取geotable_id
      geotable_id = get_geotable_id_from_list_geotable(type, cn_table_name)
      return geotable_id
    else

    end
  end

  #插入列
  def create_column(geotable_id, name, key, type, is_sortfilter_field, is_search_field, is_unique_field)
    url = 'http://api.map.baidu.com/geodata/v3/column/create'
    post_data = {
        geotable_id:   geotable_id,  	#所属于的geotable_id
        name:          name, #column的属性中文名称
        key:     key,	#column存储的属性key
        type:   type,  	#	存储的值的类型 必选，枚举值1:Int64, 2:double, 3:string, 4:在线图片url
        is_sortfilter_field:          is_sortfilter_field, #是否检索引擎的数值排序筛选字段  必选:1代表是，0代表否。
        is_search_field:     is_search_field,	#	是否检索引擎的文本检索字段  必选 1代表支持，0为不支持。
        is_unique_field: 	is_unique_field,#是否云存储唯一索引字段，方便更新，删除，查询	uint32	可选，1代表是，0代表否。设置后将在数据创建和更新时进行该字段唯一性检查，并可以以此字段为条件进行数据的更新、删除和查询。最多设置1个
        ak: $bd_lbs_ak	# 用户的访问权限key	string(50)	必选。
    }
    # puts post_data.to_json.to_s
    response = HTTParty.post(url, :body => post_data)
    data = JSON.parse(response.body)
    # puts data.to_json.to_s
    if data['status'] == 0 #创建成功
      return true
    elsif data['status'] == 1001 #列的name重复 列已存在
      return true
    else
      return false
    end
  end

  #通过查询表（list geotable）接口与表名称获取geotable_id
  def get_geotable_id_from_list_geotable(type, cn_table_name)
    url = 'http://api.map.baidu.com/geodata/v3/geotable/list?ak=' + $bd_lbs_ak # GET请求
    response = HTTParty.get(url)
    data = JSON.parse(response.body)
    # puts data.to_json.to_s
    if data['status'] == 0 #创建成功
      geotables = data['geotables']
      table_name = cn_table_name
      if Rails.env != "production"
        table_name = cn_table_name + '测试'
      end
      # puts table_name + ' == table_name ---------------'
      geotables.each do |geotable|
        if geotable['name'] == table_name
          # puts geotable['id'].to_s + '---------------'
          return geotable['id']
        end
      end
    end

    # if type == 'restaurant'
    #   if $bd_lbs_geo_table_restaurant == nil
    #     if Rails.env != "production"
    #       return $cn_restaurant_geotable_id_test
    #     else
    #       return $cn_restaurant_geotable_id
    #     end
    #   end
    # elsif type == 'user'
    #   if Rails.env != "production"
    #     return $cn_user_geotable_id_test
    #   else
    #     return $cn_user_geotable_id
    #   end
    # end

    return nil
  end

  #创建餐厅表格
  def create_restaurant_table_on_lbs
      geotable_id = create_lbs_table('restaurant', $cn_restaurant_table_name)
      # puts geotable_id + ' == geotable_id ---------------'
      if geotable_id != nil
        $bd_lbs_geo_table_restaurant = geotable_id
        success = create_column($bd_lbs_geo_table_restaurant,  '餐厅编号', 'restaurant_id', 1, 0, 0, 1)
        return success
      end
      return false
  end

  def create_restaurant_on_lbs(restaurant)
    success = true
    # if $bd_lbs_geo_table_restaurant == nil
    #   success = create_restaurant_table_on_lbs()
    # end

    if $bd_lbs_geo_table_restaurant == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id_test
      else
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id
      end
    end

    if success
      url = 'http://api.map.baidu.com/geodata/v3/poi/create'

      bd_lbs_geotable_restaurant = $bd_lbs_geo_table_restaurant
      post_data = {
          title:        restaurant.name,  	# poi名称	string(256)	可选 。
          # address:      loc.address, 	# 地址	string(256)	可选 。
          latitude:     restaurant.latitude,	# 用户上传的纬度	double	必选 。
          longitude:    restaurant.longitude,	# 用户上传的经度	double	必选 。
          restaurant_id: restaurant.id,
          coord_type: 3,	# 用户上传的坐标的类型	uint32	1：GPS经纬度坐标 2：国测局加密经纬度坐标 3：百度加密经纬度坐标 4：百度加密墨卡托坐标 必选
          geotable_id: bd_lbs_geotable_restaurant,	# 记录关联的geotable的标识	string(50)	必选，加密后的id 。
          ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
      }

      # puts post_data.to_json.to_s

      response = HTTParty.post(url, :body => post_data)
      JSON.parse(response.body)
    end
  end

  def update_restaurant_on_lbs(restaurant)
    success = true
    # if $bd_lbs_geo_table_restaurant == nil
    #   success = create_restaurant_table_on_lbs()
    # end

    if $bd_lbs_geo_table_restaurant == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id_test
      else
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id
      end
    end

    if success
      url = 'http://api.map.baidu.com/geodata/v3/poi/update'

      bd_lbs_geotable_restaurant = $bd_lbs_geo_table_restaurant
      post_data = {
          # id:     restaurant.poi_id,
          title:        restaurant.name,  	# poi名称	string(256)	可选 。
          # address:      loc.address, 	# 地址	string(256)	可选 。
          latitude:     restaurant.latitude,	# 用户上传的纬度	double	必选 。
          longitude:    restaurant.longitude,	# 用户上传的经度	double	必选 。
          restaurant_id: restaurant.id,
          coord_type: 3,	# 用户上传的坐标的类型	uint32	1：GPS经纬度坐标 2：国测局加密经纬度坐标 3：百度加密经纬度坐标 4：百度加密墨卡托坐标 必选
          geotable_id: bd_lbs_geotable_restaurant,	# 记录关联的geotable的标识	string(50)	必选，加密后的id 。
          ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
      }

      # puts post_data.to_json.to_s

      response = HTTParty.post(url, :body => post_data)
      # puts response.body.to_s
      JSON.parse(response.body)
    end
  end

  def delete_restaurant_on_lbs(restaurant_id)
    success = true
    # if $bd_lbs_geo_table_restaurant == nil
    #   success = create_restaurant_table_on_lbs()
    # end

    if $bd_lbs_geo_table_restaurant == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id_test
      else
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id
      end
    end

    if success
      url = 'http://api.map.baidu.com/geodata/v3/poi/delete'

      bd_lbs_geotable_restaurant = $bd_lbs_geo_table_restaurant
      post_data = {
          # id:     restaurant.poi_id,
          restaurant_id: restaurant_id,
          geotable_id: bd_lbs_geotable_restaurant,	# 记录关联的geotable的标识	string(50)	必选，加密后的id 。
          ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
      }

      # puts post_data.to_json.to_s

      response = HTTParty.post(url, :body => post_data)
      # puts response.body.to_s
      JSON.parse(response.body)
    end
  end

  #创建用户表格
  def create_user_table_on_lbs
    geotable_id = create_lbs_table('user', $cn_user_table_name)
    # puts geotable_id + ' == geotable_id ---------------'
    if geotable_id != nil
      $bd_lbs_geo_table_user = geotable_id
      success = create_column($bd_lbs_geo_table_user,  '用户编号', 'user_id', 1, 0, 0, 1)
      success = success && create_column($bd_lbs_geo_table_user,  '性别', 'sex', 1, 1, 0, 0)
      return success
    end
    return false
  end

  def create_user_on_lbs(user)
    success = true
    # if $bd_lbs_geo_table_user == nil
    #   success = create_user_table_on_lbs()
    # end

    if $bd_lbs_geo_table_user == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_user = $cn_user_geotable_id_test
      else
        $bd_lbs_geo_table_user = $cn_user_geotable_id
      end
    end

    if success
      url = 'http://api.map.baidu.com/geodata/v3/poi/create'

      bd_lbs_geotable_user = $bd_lbs_geo_table_user
      post_data = {
          title:        user[:show_name],  	# poi名称	string(256)	可选 。
          # address:      loc.address, 	# 地址	string(256)	可选 。
          latitude:     user[:latitude],	# 用户上传的纬度	double	必选 。
          longitude:    user[:longitude],	# 用户上传的经度	double	必选 。
          user_id: user[:id],
          sex: user[:sex],
          coord_type: 3,	# 用户上传的坐标的类型	uint32	1：GPS经纬度坐标 2：国测局加密经纬度坐标 3：百度加密经纬度坐标 4：百度加密墨卡托坐标 必选
          geotable_id: bd_lbs_geotable_user,	# 记录关联的geotable的标识	string(50)	必选，加密后的id 。
          ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
      }

      # puts post_data.to_json.to_s

      response = HTTParty.post(url, :body => post_data)
      # puts response.body.to_s
      # data = JSON.parse(response.body)
      # poi_id = data[:id]
      #
      # my_user = User.find_by(id: user[:id])
      # unless my_user
      #   return
      # end
      # my_user.update(:poi_id => poi_id)

    end
  end

  def update_user_on_lbs(user)
    success = true
    # if $bd_lbs_geo_table_user == nil
    #   success = create_user_table_on_lbs()
    # end

    if $bd_lbs_geo_table_user == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_user = $cn_user_geotable_id_test
      else
        $bd_lbs_geo_table_user = $cn_user_geotable_id
      end
    end

    if success
      url = 'http://api.map.baidu.com/geodata/v3/poi/update'

      bd_lbs_geotable_user = $bd_lbs_geo_table_user
      post_data = {
          title:        user[:show_name],  	# poi名称	string(256)	可选 。
          # address:      loc.address, 	# 地址	string(256)	可选 。
          latitude:     user[:latitude],	# 用户上传的纬度	double	必选 。
          longitude:    user[:longitude],	# 用户上传的经度	double	必选 。
          user_id: user[:id],
          sex: user[:sex],
          coord_type: 3,	# 用户上传的坐标的类型	uint32	1：GPS经纬度坐标 2：国测局加密经纬度坐标 3：百度加密经纬度坐标 4：百度加密墨卡托坐标 必选
          geotable_id: bd_lbs_geotable_user,	# 记录关联的geotable的标识	string(50)	必选，加密后的id 。
          ak: $bd_lbs_ak,	# 用户的访问权限key	string(50)	必选。
      }

      # puts post_data.to_json.to_s

      response = HTTParty.post(url, :body => post_data)
      # puts response.body.to_s
      JSON.parse(response.body)
    end
  end

  # filter = {
  #     sex: '性别 0:女　１：男',
  #     longitude: '经度',
  #     latitude: '纬度',
  #     radius: '范围　单位为米',
  #     page: '当前页标，从0开始, 默认为0',
  #     page_size: '当前页面最大结果数 默认为10，最多为50'
  # }
  def get_around_users(filter)
    if $bd_lbs_geo_table_user == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_user = $cn_user_geotable_id_test
      else
        $bd_lbs_geo_table_user = $cn_user_geotable_id
      end
    end

    bd_lbs_geotable_test_user = $bd_lbs_geo_table_user
    filters = ''
    filters += 'sex:' + filter[:sex].to_s + '|' if filter && filter[:sex]
    sortbys = 'distance:1' #默认距离升序
    # sortbys += '|' + 'age:' + sortby[:age].to_s if sortby && sortby[:age]
    if filter && filter[:sex]
      get_data = {
          ak:$bd_lbs_ak,
          geotable_id: bd_lbs_geotable_test_user,
          location:  filter[:longitude].to_s+ ',' + filter[:latitude].to_s,   # 逗号分隔的经纬度
          coord_type:3,  # 3代表百度经纬度坐标系统 4代表百度墨卡托系统
          radius: filter[:radius] || 80000,       # 单位为米，默认为1000
          filter:filters[0, filters.length - 1], #去掉最后多余的分隔符
          sortby: sortbys,       # 格式为sortby={key1}:value1|{key2:val2|key3:val3}。 最多支持16个字段排序 {keyname}:1 升序 {keyname}:-1 降序 以下keyname为系统预定义的： distance 距离排序 weight 权重排序
          page_index: filter[:page],   # 当前页标，从0开始, 默认为0
          page_size: filter[:page_size]    # 当前页面最大结果数 默认为10，最多为50
          #callback:, js回调函数
          #sn:     用户的权限签名
      }
    else
      get_data = {
          ak:$bd_lbs_ak,
          geotable_id: bd_lbs_geotable_test_user,
          location:  filter[:longitude].to_s+ ',' + filter[:latitude].to_s,   # 逗号分隔的经纬度
          coord_type:3,  # 3代表百度经纬度坐标系统 4代表百度墨卡托系统
          radius: filter[:radius] || 80000,       # 单位为米，默认为1000
          sortby: sortbys,       # 格式为sortby={key1}:value1|{key2:val2|key3:val3}。 最多支持16个字段排序 {keyname}:1 升序 {keyname}:-1 降序 以下keyname为系统预定义的： distance 距离排序 weight 权重排序
          page_index: filter[:page],   # 当前页标，从0开始, 默认为0
          page_size: filter[:page_size]    # 当前页面最大结果数 默认为10，最多为50
          #callback:, js回调函数
          #sn:     用户的权限签名
      }
    end

    puts "=------------------------get_data:"+get_data.to_s
    url = 'http://api.map.baidu.com/geosearch/v3/nearby' + '?'
    for obj in get_data
      url += obj[0].to_s + '=' + obj[1].to_s + '&' if obj[1]
    end
    # puts url
    response = HTTParty.get url[0,url.length-1]
    JSON.parse(response.body)
  end

  # filter = {
  #     longitude: '经度',
  #     latitude: '纬度',
  #     radius: '范围　单位为米',
  #     page: '当前页标，从0开始, 默认为0',
  #     page_size: '当前页面最大结果数 默认为10，最多为50'
  # }
  # filter = {longitude: '113.905549',latitude: '22.57464',radius: '5000',page: '0',page_size: '50'}
  def get_around_restaurants(filter)
    if $bd_lbs_geo_table_restaurant == nil
      if Rails.env != "production"
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id_test
      else
        $bd_lbs_geo_table_restaurant = $cn_restaurant_geotable_id
      end
    end
    bd_lbs_geotable_hot_hotel = $bd_lbs_geo_table_restaurant
    sortbys = 'distance:1' #默认距离升序
    get_data = {
        ak:$bd_lbs_ak,
        geotable_id: bd_lbs_geotable_hot_hotel,
        location: filter[:longitude].to_s + ',' + filter[:latitude].to_s,   # 逗号分隔的经纬度
        coord_type:3,  # 3代表百度经纬度坐标系统 4代表百度墨卡托系统
        radius: filter[:radius] || 80000,       # 单位为米，默认为1000
        sortby: sortbys,       # 格式为sortby={key1}:value1|{key2:val2|key3:val3}。 最多支持16个字段排序 {keyname}:1 升序 {keyname}:-1 降序 以下keyname为系统预定义的： distance 距离排序 weight 权重排序
        page_index: filter[:page],   # 当前页标，从0开始, 默认为0
        page_size: filter[:page_size]    # 当前页面最大结果数 默认为10，最多为50
        #callback:, js回调函数
        #sn:     用户的权限签名
    }
    url = 'http://api.map.baidu.com/geosearch/v3/nearby' + '?'
    for obj in get_data
      url += obj[0].to_s + '=' + obj[1].to_s + '&' if obj[1]
    end
    # puts url
    response = HTTParty.get url[0,url.length-1]
    JSON.parse(response.body)
  end

  def get_around_restaurants_one_page(page)
    restaurants = []
    longitude = $longitude
    latitude = $latitude
    if $longitude == nil || $latitude == nil
      longitude = $shenzhen_center_longitude
      latitude = $shenzhen_center_latitude
    end
    restaurant_filter = {
        longitude: longitude,
        latitude: latitude,
        radius: '500000000',
        page: page, #'当前页标，从0开始, 默认为0',
        page_size: 10 #'当前页面最大结果数 默认为10，最多为50'
    }
    restaurants_lbs_data = get_around_restaurants(restaurant_filter)
    contents = restaurants_lbs_data['contents']
    if contents
      contents.each do |content|
        # puts '--------------------content: ' + content.to_json.to_s
        # {"restaurant_id":1,"uid":1643845081,"province":"湖南省","geotable_id":135610,"district":"浏阳市","create_time":1457938948,"city":"长沙市","location":[113.934232,28.2132123],"title":"鑫源餐厅","coord_type":3,"direction":"南","type":0,"distance":641780,"weight":0}
        restaurant_id = content['restaurant_id']
        distance = content['distance']
        restaurant = Restaurant.find_by(id: restaurant_id)
        if restaurant
          distance_s = distance.to_s + 'm'
          if distance > 1000
            distance_s = (distance/1000).to_s + 'km'
          end
          re = {
              id: restaurant.id,
              name: restaurant.name, #名称
              image: restaurant.image, #主图
              address: restaurant.address, #详细地址
              longitude: restaurant.longitude, #经度
              latitude: restaurant.latitude, #纬度
              province: restaurant.province, #省份
              city: restaurant.city, #城市
              region: restaurant.region, #地区
              road: restaurant.road, #路
              tagging: restaurant.tagging, #标签
              introduction: restaurant.introduction, #简介
              telephone: restaurant.telephone, #电话
              has_wifi: restaurant.has_wifi, #有无WIFI
              has_parking: restaurant.has_parking, #有无停车区
              distance: distance_s
          }
          restaurants.push(re)
        end
      end
    end
    return restaurants
  end

  def get_around_user_one_page(sex, page)
    users = []
    longitude = $longitude
    latitude = $latitude
    if $longitude == nil || $latitude == nil
      longitude = $shenzhen_center_longitude
      latitude = $shenzhen_center_latitude
    end

    user_sex = 0
    if sex == 0
      user_sex = 0
    elsif sex == 1
      user_sex = 1
    end

    if user_sex != 0 && user_sex != 1
    user_filter = {
        # sex: user_sex,
        longitude: longitude,
        latitude: latitude,
        radius: '50000',
        page: page, #'当前页标，从0开始, 默认为0',
        page_size: 10 #'当前页面最大结果数 默认为10，最多为50'
    }
    else
      user_filter = {
          longitude: longitude,
          latitude: latitude,
          radius: '50000',
          page: page, #'当前页标，从0开始, 默认为0',
          page_size: 10 #'当前页面最大结果数 默认为10，最多为50'
      }
    end

    users_lbs_data = get_around_users(user_filter)
    puts "=------------------------users_lbs_data:"+users_lbs_data.to_s
    contents = users_lbs_data['contents']
    if contents
      contents.each do |content|
        # puts '--------------------content: ' + content.to_json.to_s
        # {"restaurant_id":1,"uid":1643845081,"province":"湖南省","geotable_id":135610,"district":"浏阳市","create_time":1457938948,"city":"长沙市","location":[113.934232,28.2132123],"title":"鑫源餐厅","coord_type":3,"direction":"南","type":0,"distance":641780,"weight":0}
        user_id = content['user_id']
        distance = content['distance']
        user = User.find_by(id: user_id)
        # puts 'ssssssssssssssssssssssss'+user.to_json.to_s

        if user
          distance_s = distance.to_s + 'm'
          if distance > 1000
            distance_s = (distance/1000).to_s + 'km'
          end
          user_info = UserInfo.find_by(user_id: user.id)
          age = '未知'
          if user_info
            age = user_info.age
          end
          f = {
              id: user.id,
              show_name: user.show_name,#微信用户不可修改
              avatar: user.avatar,
              username: user.username,
              sex:user.sex,
              age: age,
              distance: distance_s
          }
          users.push(f)
        end
      end
    end
    return users
  end

end