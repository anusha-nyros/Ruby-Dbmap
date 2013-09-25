class Admin::HomeController < Admin::AdminController
before_filter :authorize
  def index
    redirect_to databases_path 
  end
end
