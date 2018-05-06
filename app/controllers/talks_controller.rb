class TalksController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /talks
  def create
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    session_end = true
    
    response.add_speech("#{request.intent.name}")
    
    case request.type
      when 'LAUNCH_REQUEST'
        response.add_speech("スマートバルクへようこそ。体重と体脂肪率の管理をします。管理をしますか？")
        session_end = false
      when 'INTENT_REQUEST'
        case request.intent.name 
          when 'WeightManagement'
            weight = request.intent.slots[:weight][:value]
            response.add_speech("#{weight}キログラムですね。体脂肪率は何％ですか？")
            response.add_session_attribute :weight, weight
            session_end = false
          when 'BodyfatpercentageManagement'
            weight = request.session.attributes[:weight]
            bodyfatpercentage = request.intent.slots[:bodyfatpercentage][:value]
            # TODO: DB登録処理を入れる
            response.add_speech("#{bodyfatpercentage}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
        end
    end
    
    render json: response.build_response
  end
end