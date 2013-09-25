class SessionsController < ApplicationController
  layout "sign_in"
  def new
    if current_user
      if current_user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    end
  end
  
 def create
    @user = login(params[:username], params[:password], params[:remember_me])
   # @user = User.find_by_username(params[:username])
    if @user
      if !@user.active?
       logout
       flash.now[:error] = "User are not active"
       render :new
      else
        auto_login(@user)
        if current_user.admin?
        redirect_back_or_to databases_url #, notice: "Logged in!" 
        else 
         redirect_back_or_to databases_url #, notice: "Logged in!" 
        end 
      end
    else
      flash.now[:error] = "User name or password  was invalid"
      render :new
    end
  end
  
  def destroy
    logout
    #redirect_to login_url, notice: "Logged out!"
     redirect_to root_path
  end
end
