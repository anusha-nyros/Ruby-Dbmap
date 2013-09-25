class HomeController < ApplicationController
  before_filter :authorize
  def index
    redirect_to databases_path 
  end
end
