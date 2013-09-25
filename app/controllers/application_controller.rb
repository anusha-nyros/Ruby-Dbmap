class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    redirect_to login_url, alert: "Please log in first!" unless current_user 
  end
 
#for changing the date format in to mm/yy/dd while creating time
 def change_date_format(date)
    date_array = date.split("/")
    new_date = date_array[1]+"/"+date_array[2]+"/"+date_array[0]
    puts new_date.inspect
    return new_date
  end
   # for auto login
   def get_logged
	@user = User.find(1)
       auto_login(@user)
   end 
end
