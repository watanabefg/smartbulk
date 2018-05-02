class TalksController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /talks
  def create
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    
    if request.slots[:weight][:value]
      response.add_speech("#{request.slots[:weight][:value]}キログラムですね。")
    end
    
    if request.slots[:bodyfatpercentage][:value]
      response.add_speech("#{request.slots[:bodyfatpercentage][:value]}パーセントですね。")
    end
    
    render json: response.build_response
  end
end