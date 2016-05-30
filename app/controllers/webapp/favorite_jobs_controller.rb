class Webapp::FavoriteJobsController < ApplicationController
  def index
    # @data = get_favorite_jobs(current_user.id)
    puts 'ssssssss' + @data.to_json.to_s
  end
end
