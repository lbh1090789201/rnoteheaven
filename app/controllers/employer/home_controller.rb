class Employer::HomeController < ApplicationController
  before_action :require_employer!

  def index
  end
end
