class Api::V1::TalksController < Api::V1::ApiController#Grape::API 
  protect_from_forgery :except => [:create]

  # POST /talks
  def create
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    session_end = true
   
    case request.type
      when 'LAUNCH_REQUEST'
        # アカウントリンクの確認
        user = request.session.user
        
        if !user.has_key?(:accessToken) then
          # アクセストークンが未定義の場合はアカウントリンク設定を促す
          response.add_card("LinkAccount")
          response.add_speech("アレクサアプリでアカウントのリンクをしてからご利用ください。")
        else
          #accessToken = user[:accessToken]
          
          # Login with AmazonのリクエストURLにアクセストークンを付与
          # url = 'https://api.amazon.com/user/profile?access_token=' + accessToken;
          # httpsモジュールでリクエストを送出
          response.add_speech("スマートバルクへようこそ。体重と体脂肪率の管理をします。管理をしますか？")
          session_end = false
        end
      when 'INTENT_REQUEST'
        case request.intent[:name]
          when 'AMAZON.YesIntent'
            response.add_speech("体重は何キログラムですか？")
            session_end = false
          when 'AMAZON.NoIntent'
          when 'AMAZON.CancelIntent'
            response.add_speech("ご利用ありがとうございました。またスマートバルクをご利用ください。")
          when 'WeightManagement'
            weight = request.slots[:weight][:value]
            response.add_speech("#{weight}キログラムですね。体脂肪率は何％ですか？")
            response.add_session_attribute :weight, weight
            session_end = false
          when 'BodyfatpercentageManagement'
            weight = request.session.attributes[:weight]
            bodyfatpercentage = request.slots[:bodyfatpercentage][:value]
            
            con = ActiveRecord::Base.connection
            sql = ActiveRecord::Base.send(
              :sanitize_sql_array,
              ['SELECT resource_owner_id from oauth_access_tokens WHERE token=?', request.session.user[:accessToken]]
            )
            resource_owner_id = con.select_value(sql)
            record = Record.new(:user_id => resource_owner_id, :weight => weight, :fatPer => bodyfatpercentage)
            if record.save
              response.add_speech("#{bodyfatpercentage}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
            end
        end
    end
    
    render json: response.build_response(session_end)
  end
end