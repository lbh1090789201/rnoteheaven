class Employer::HomeController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
  end
end
