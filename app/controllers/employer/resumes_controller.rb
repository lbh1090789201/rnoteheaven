class Employer::ResumesController < ApplicationController
  before_action :require_employer!
  layout "employer"

  def index
  end

  def show
  end
end
