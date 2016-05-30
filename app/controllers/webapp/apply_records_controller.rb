include Webapp::ApplyRecordsHelper

class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  helper_method :apply_records_infos

  def index
    @data = get_apply_records(current_user.id)
  end

  def show
  end
end
