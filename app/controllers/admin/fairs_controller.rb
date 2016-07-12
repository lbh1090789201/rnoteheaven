class Admin::FairsController < AdminController
  before_action :require_fairs_manager!

  def index
  end

  def history
  end
end
