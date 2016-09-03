class Webapp::HomeController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    # @fhas_new = FavoriteJob.where(:has_new => true, :user_id => current_user.id)
    @has_new_length = ApplyRecord.where(:has_new => true, :user_id => current_user.id).length
    # @has_new_length = @fhas_new.length + @ahas_new.length

    filter = params

    #只搜索城市
    if filter[:city]
      @jobs = Job.filter_location(filter[:city]).filter_job_status("release")
      current_user.update search_city: filter[:city] if current_user.search_city != filter[:city]
    else
      @search_city = get_search_city
      @jobs = Job.filter_location(@search_city).filter_job_status("release")
    end

    #搜索城市和医院
    if filter[:city] && filter[:search] && !filter[:search].blank?
      job_careers = Job.filter_location(filter[:city])
                       .filter_job_name(filter[:search])
                       .filter_job_status("release")
      hospitals = Hospital.filter_location(filter[:city]).filter_hospital_name(filter[:search])

      @jobs = []
      if !job_careers.blank?
        job_careers.each do |j|
          @jobs.push(j)
        end
      else
        hospitals.each do |h|
          job_all = Job.filter_job_status("release")
                       .where(:hospital_id => h.id)
          job_all.each do |j|
            @jobs.push(j)
          end
        end
      end

      current_user.update search_city: filter[:city] if current_user.search_city != filter[:city]
    end

      @arjob = []
      @jobs.each do |r|
        hospital = Hospital.find_by_id r.hospital_id
        o = {
          id: r.id,
          job_name: r.name,
          salary_range: r.salary_range,
          region: r.region,
          hospital_name: hospital.name,
          city: filter[:city]
        }
        @arjob.push(o)
      end
    return @arjob

  end

  private
    def get_search_city
      if current_user.search_city.present?
        return current_user.search_city
      elsif current_user.location.present?
        return current_user.location
      elsif params[:lat] && params[:lng]
        return get_location params[:lat], params[:lng]
      else
        return '广州市'
      end
    end

    ###################### 通过经纬度从百度获取数据 ######################
    def get_location lat, lng
      # lat 纬度 32.055677
      # lng 经度 118.802891
      res = RestClient.get "http://api.map.baidu.com/geocoder/v2/", {
        params: {
          ak: 'RBFDlZ7kBtxeP8McYkaTxm7aDZ9UwlXy',
          location: "#{lat},#{lng}",
          output: 'json',
          pois: 1
        },  :accept => :json
      }

      info = JSON.parse(res.body)

      return info["result"]["addressComponent"]["city"]
    end
end
