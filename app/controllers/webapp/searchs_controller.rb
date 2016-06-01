include Webapp::SearchsHelper

class Webapp::SearchsController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  helper_method :get_searchs

  def index
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
