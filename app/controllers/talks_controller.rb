class TalksController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /talks
  def create
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    session_end = true
    
    case request.type
      when 'LAUNCH_REQUEST'
        response.add_speech("スマートバルクへようこそ。体重と体脂肪率の管理をします。管理をしますか？")
        session_end = false
      when 'INTENT_REQUEST'
        case request.intent[:name]
          when 'AMAZON.YesIntent'
            response.add_speech("体重は何キログラムですか？")
            session_end = false
          when 'AMAZON.NoIntent'
            response.add_speech("ご利用ありがとうございました。またスマートバルクをご利用ください。")
          when 'WeightManagement'
            weight = request.slots[:weight][:value]
            response.add_speech("#{weight}キログラムですね。体脂肪率は何％ですか？")
            response.add_session_attribute :weight, weight
            session_end = false
          when 'BodyfatpercentageManagement'
            weight = request.session.attributes[:weight]
            bodyfatpercentage = request.slots[:bodyfatpercentage][:value]
            loop do
              # TODO: user_idはアカウントリンキングで取得しておく
              user_id = 1
              record = Record.new(:user_id => user_id, :weight => weight, :fatPer => bodyfatpercentage)
              break if record.save
            end 
            response.add_speech("#{bodyfatpercentage}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
        end
    end
    
    render json: response.build_response(session_end)
  end
end