class Dashboard::UsersController < Dashboard::BaseController

  def index
    @users = User.search_and_order(params[:search], params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end



end
