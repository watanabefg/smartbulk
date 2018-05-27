module UsersHelper
  def getUserRecord(scale)
    weight = [] 
    bodyfatPer = [] 
    date = [] 
  
    rec_num = 0   #取得するレコードの数
    cnt = 0
    
    case scale
      when "week" then
        rec_num = 7      
      when "month" then
        rec_num = 31
      when "three_month" then
        rec_num = 90
      when "six_month" then
        rec_num = 183
      else
        rec_num = 7   #Fail 
    end
    
    # Recordインスタンスから体重、体脂肪率、日付の情報を取得
    @all_usr_data.each do |record| 
       weight.push(record.weight)   
       bodyfatPer.push(record.fatPer) 
       md = record.created_at.strftime("%-m/%-d") 
       date.push(md)  
       cnt = cnt + 1
       
       #week month 3month 6month の設定によって取得レコード数を切り替え
       if cnt == rec_num then
         break
       end
    end 
    
    return  weight, bodyfatPer, date
  end
end
