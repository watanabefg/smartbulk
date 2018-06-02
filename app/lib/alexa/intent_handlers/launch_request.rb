class Alexa::IntentHandlers::LaunchRequest < Alexa::IntentHandlers::LaunchApp
  #before_action :authenticate_user!, only: []
  protect_from_forgery :except => [:create]
  
  def handle
    logger.debug("すごいな")
    response # intent handlers should always return the +response+ object 
  end
end