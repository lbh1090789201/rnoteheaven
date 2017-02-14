class CollectionsController < ApplicationController
  before_action do
    @user_id = current_user.id if current_user
    authenticate_user!
  end
end
