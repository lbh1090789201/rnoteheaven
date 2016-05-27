include Webapp::ApplyRecordsHelper

class Webapp::ApplyRecordsController < ApplicationController
  before_action :authenticate_user!
  helper_method :apply_records_infos

  def index

    # @data = get_date(current_user.id)
    puts 'bbbbbbbbbbb' + @data.to_json.to_s

  end

  def show
  end
end
