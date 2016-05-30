class Webapp::SearchsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index
    # 搜索判定
    # if params[:button] && params[:button] == "search"
    #   @jobs = Job.location(params[:search][0])
    # else
    #   @jobs = Job.location("深圳")
    # end

    #职位搜索判定
    if params[:button] && params[:button] == "search"
      @jobs = Job.position_name(params[:search][0])
    else
      @jobs = Job.position_name("护士i")
    end

    #医院搜索判定
    if params[:button] && params[:button] == "search"
      @jobs = Job.hospital_name(params[:search][0])
    else
      @jobs = Job.hospital_name("南方醫院")
    end
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def search
  end
end
