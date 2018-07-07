module UsersHelper
  def get_user_record(scale)
    weight = [] 
    bodyFatPer = [] 
    date = [] 
  
    case scale
      when "week" then
        records = @week_user_records
      when "month" then
        records = @month_user_records
      when "three_month" then
        records = @month3_user_records
      when "six_month" then
        records = @month6_user_records
      else
        records = @week_user_records #Fail 
    end
    
    # Recordインスタンスから体重、体脂肪率、日付の情報を取得
    records.each do |record| 
       weight.push(record.weight)   
       bodyFatPer.push(record.fatPer) 
       md = record.created_at.strftime("%-m/%-d") 
       date.push(md)  
    end 
    
    return  weight, bodyFatPer, date
  end

  def get_history_dat
    cnt = 0
    weight_per = []   # 体重変化量
    bodyFatPer_per = []   # 体脂肪変化量
    weight     = [] 
    bodyFatPer = [] 
    date       = [] 
    tmp_w  = 0
    tmp_fp = 0

    @all_user_records.each do |record| 
      weight.push(record.weight)   
      bodyFatPer.push(record.fatPer) 
      
      md = record.created_at.strftime("%-m/%-d") 
      date.push(md) 
      
      # Recordが一つしかない場合は変化率0を代入
      if (@all_user_records.count == 1) then
        weight_per.push(0)
        bodyFatPer_per.push(0)
        break
      elsif(cnt == 0)
        # NO ACTION
      else
        w  = tmp_w - record.weight
        fp = tmp_fp - record.fatPer
        
        weight_per.push(BigDecimal(w.to_s).ceil(2).to_f)
        bodyFatPer_per.push(BigDecimal(fp.to_s).ceil(2).to_f)
      end
      
      # 一時保存
      tmp_w  = record.weight
      tmp_fp = record.fatPer
            
      cnt = cnt + 1
    end     
    
    return  weight, bodyFatPer, date, weight_per, bodyFatPer_per
  end
  
end
