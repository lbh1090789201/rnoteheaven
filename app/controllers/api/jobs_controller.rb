class Api::JobsController < ApiController
  before_action :authenticate_user!   # 登陆验证

  #post to search
  def search
    filter = {}
    if params[:filter]
      filter = params[:filter]
    else
      filter = params
    end

    @jobs = search_by_filter(filter)
    if @jobs.size == 0 && (filter[:hospital_name] || filter[:job_name])
      #switch hospital and job name
      name = filter[:job_name]
      hospital = filter[:hospital_name]
      if name
        filter[:hospital_name] = name
      else
        filter[:hospital_name] = nil
      end
      if hospital
        filter[:job_name] = hospital
      else
        filter[:job_name] = nil
      end

      @jobs = search_by_filter filter
    end
  end

  #精确匹配优先，模糊匹配次之，最后是Join子表
  def search_by_filter(filter)
    return Job.filter_job_name(filter[:job_name])
               .filter_hospital_name(filter[:hospital_name])
               .filter_location(filter[:location])
  end

end
