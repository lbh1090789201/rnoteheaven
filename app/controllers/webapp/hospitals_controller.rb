class Webapp::HospitalsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证

  def index

  end
end
