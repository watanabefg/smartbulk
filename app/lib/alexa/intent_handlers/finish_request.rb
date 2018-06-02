class Alexa::IntentHandlers::FinishRequest < Alexa::IntentHandlers::SessionEnd
  def handle
    response # intent handlers should always return the +response+ object 
  end
end