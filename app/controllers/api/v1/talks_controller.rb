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
            weight = getWeight(request)
            
            if weight == 0 then
              response.add_speech("体重は何キログラムですか？")
            else
              if hasDot(request) then
                dotnumber = getDotNumber(request)
                
                if dotnumber == 0 then
                  response.add_speech("体重は何キログラムですか？")
                else
                  response.add_speech("#{weight}てん#{dotnumber}キログラムですね。体脂肪率は何％ですか？")
                  weight = (weight.to_s + "." + dotnumber.to_s).to_f
                  response.add_session_attribute :weight, weight
                end
              else
                response.add_speech("#{weight}キログラムですね。体脂肪率は何％ですか？")
                response.add_session_attribute :weight, weight
              end
            end
            
            session_end = false
          when 'BodyfatpercentageManagement'
            weight = request.session.attributes[:weight]
            bodyfatpercentage = getBodyFatPercentage(request)
            
            if bodyfatpercentage == 0 || bodyfatpercentage >= 100 then
              response.add_speech("体脂肪率は何パーセントですか？")
              session_end = false
            else
              if hasDot(request) then
                dotnumber = getDotNumber(request)
              
                if dotnumber == 0 then
                  response.add_speech("体脂肪率は何パーセントですか？")
                  session_end = false
                else
                  fatPer = (bodyfatpercentage.to_s + "." + dotnumber.to_s).to_f
                  resource_owner_id = getResourceOwnerId(request)
                  record = Record.new(:user_id => resource_owner_id, :weight => weight, :fatPer => fatPer)
                  
                  if record.save
                    response.add_speech("#{bodyfatpercentage}てん#{dotnumber}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
                  end
                end
              else
                fatPer = bodyfatpercentage
                resource_owner_id = getResourceOwnerId(request)
                record = Record.new(:user_id => resource_owner_id, :weight => weight, :fatPer => fatPer)
                
                if record.save
                  response.add_speech("#{bodyfatpercentage}パーセントですね。登録しました。マイページにアクセスすると履歴が確認できます。")
                end
              end
            end
        end
    end
    
    render json: response.build_response(session_end)
  end
  
  private
  def getWeight(request)
    if request.slots[:weight][:value].present? then
      weight = request.slots[:weight][:value]
      if /^[0-9]+$/ =~ weight
        return weight
      end
    end
    return 0
  end
  
  def hasDot(request)
    if request.slots[:dotnumber][:value].present? then
      return true
    end
    return false
  end
      
  def getDotNumber(request)
    if request.slots[:dotnumber][:value].present? then
      dotnumber = request.slots[:dotnumber][:value]
      if /^[0-9]+$/ =~ dotnumber
        return dotnumber
      end
    end
  end
  
  def getBodyFatPercentage(request)
    if request.slots[:bodyfatpercentage][:value].present? then
      bodyfatpercentage = request.slots[:bodyfatpercentage][:value]
      if /^[0-9]+$/ =~ bodyfatpercentage
        return bodyfatpercentage
      end
    end
  end
 
  def getResourceOwnerId(request)
    con = ActiveRecord::Base.connection
    sql = ActiveRecord::Base.send(
      :sanitize_sql_array,
      ['SELECT resource_owner_id from oauth_access_tokens WHERE token=?', request.session.user[:accessToken]]
    )
    return con.select_value(sql)
  end
end