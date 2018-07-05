module UsersHelper
  def get_user_record(scale)
    weight = [] 
    bodyfatPer = [] 
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
       bodyfatPer.push(record.fatPer) 
       md = record.created_at.strftime("%-m/%-d") 
       date.push(md)  
    end 
    
    return  weight, bodyfatPer, date
  end

  # マクロ定義
  HISTORY_DSP_MAX = 5 
  def get_history_dat
    cnt = 0
    weight_per = []   # 体重変化量
    bodyfp_per = []   # 体脂肪変化量
    weight     = [] 
    bodyfatPer = [] 
    date       = [] 
    tmp_w  = 0
    tmp_fp = 0
    
    @all_usr_records.each do |record| 
      weight.push(record.weight)   
      bodyfatPer.push(record.fatPer) 
      
      md = record.created_at.strftime("%-m/%-d") 
      date.push(md)  
      
      # Recordが一つしかない場合は変化率0を代入
      if (@rcd_num - 1 == 0) then
        weight_per.push(0)
        bodyfp_per.push(0)
        break
      elsif(cnt == 0)
        # NO ACTION
      else
        w  = record.weight - tmp_w
        fp = record.fatPer - tmp_fp
        
        weight_per.push(BigDecimal(w.to_s).ceil(2).to_f)
        bodyfp_per.push(BigDecimal(fp.to_s).ceil(2).to_f)
      end
      
      # 一時保存
      tmp_w  = record.weight
      tmp_fp = record.fatPer
            
      cnt = cnt + 1
    end     
    
    return  weight, bodyfatPer, date, weight_per, bodyfp_per
  end
  
end
