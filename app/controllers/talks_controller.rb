class TalksController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /talks
  def create
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    session_end = true
    
    case request.name
      when 'WeightManagement'
        weight = request.slots[:weight][:value]
        response.add_speech("#{weight}キログラムですね。体脂肪率は何％ですか？")
        response.add_session_attribute :weight, weight
        session_end = false
      when 'BodyfatpercentageManagement'
        weight = request.session.attributes[:weight]
        bodyfatpercentage = request.slots[:bodyfatpercentage][:value]
        # TODO: DB登録処理を入れる
        response.add_speech("#{bodyfatpercentage}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
    end
    
    render json: response.build_response
  end
end