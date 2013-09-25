class NotificationMailer < ActionMailer::Base
 # default from: "from@example.com"

   def testmail
   
    mail(:from => "MobiFiler<noreply@towersuiux.com>",
       :to => "ratnakarrao_nyros@yahoo.com",
       :subject => "account notification")
   end
   
   def create_account(user)
     @user=user
    mail(:from => "Pattern Library<noreply@towersuiux.com>",
         :to => "ranjit_nyros@yahoo.com",
         :subject => "new account notification")
   end  

    def orguser_notify(user)
        @user=user
         mail(:from => "Pattern Library<noreply@towersuiux.com>",
         :to => "ranjit_nyros@yahoo.com",
         :subject => "new account notification")
    end  


  def feedback(first_name,last_name,email,message,company_name,msgtype)
      @first_name = first_name
      @last_name = last_name
      @email = email
      @message = message
      @company_name = company_name
         mail(:from => "Pattern Library<noreply@towersuiux.com>",
               :to => "info@towersuiux.com",
               :cc => "ranjit_nyros@yahoo.com",
               :subject => msgtype,
               :date => Time.now)

end

def thanks_feedback_email(first_name,last_name,email)
      @first_name = first_name
      @last_name = last_name
      @email = email

         mail(:from => "Pattern Library<noreply@towersuiux.com>",
               :to => email,
               :subject => "Thank You  ",
               :date => Time.now)

end 




end
