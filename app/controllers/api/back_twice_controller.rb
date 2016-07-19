class Api::BackTwiceController < ApplicationController
  def index
    render js: 'history.go(-2); location.reload()'
  end
end
