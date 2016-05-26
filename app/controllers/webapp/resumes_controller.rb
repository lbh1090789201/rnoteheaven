class Webapp::ResumesController < ApplicationController
  before_action :authenticate_user!   # 登陆验证
  def index
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
    
  end

  def edit
    if params[:val] == 'basic'
      # render partial: "edit_basic", layout: "header"
      # @val = 'basic'
    end
  end
end
