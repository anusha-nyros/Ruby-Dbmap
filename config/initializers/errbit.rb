if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key		 	= '55a6b87fcc5dd21281cffcb4be90cf81'
    config.host				= 'salah.herokuapp.com'
    config.port				= 80
    config.secure			= config.port == 443
  end
end