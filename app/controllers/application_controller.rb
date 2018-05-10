class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end  

  ###########################################
  #　関数名：　  recordSaveBulk
  #　引数1：　   weight       体重
  #　引数2：　   bodyFatPer   体脂肪
  #　処理：　　　体重と体脂肪をテーブルに登録する。引数が0であれば終了する
  #　関連table： Record
  ###########################################  
  def recordSaveBulk(weight, bodyFatPer)

    # 引数の値が0であれば登録せずに終了
    if((weight == 0) || (bodyFatPer == 0))
      logger.info("[recordSaveBulk]argument = 0")
      return false
    end
    
    # Recordテーブルに登録
    bulkParam = {weight: weight, fatPer: bodyFatPer}
    @record = current_user.records.build(bulkParam)
    
    if @record.save
      logger.info("[recordSaveBulk]record.save is success.")
      return true
    else
      logger.error("[recordSaveBulk]record.save is fail.")
      return false
    end    
  end  

end
