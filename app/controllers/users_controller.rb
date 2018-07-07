class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:show]

  def show
    d = Date.today
    @user = User.find(params[:id])
    @latest_data = Record.where(user_id: current_user.id).order('created_at DESC').first
    unless @latest_data
      @latest_data = Record.new(user_id: current_user.id, weight: 0.0, fatPer: 0.0)
    end
    # ユーザーの登録しているレコード情報を全て取得
    @all_user_records = Record.where(user_id: current_user.id).order('created_at DESC')
    
    @week_user_records = Record.where(user_id: current_user.id).where('created_at >= ?', d-7).order('created_at')
    @month_user_records = Record.where(user_id: current_user.id).where('created_at >= ?', d-30).order('created_at')
    @month3_user_records = Record.where(user_id: current_user.id).where('created_at >= ?', d-90).order('created_at')
    @month6_user_records = Record.where(user_id: current_user.id).where('created_at >= ?', d-180).order('created_at')
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :goalWeight, :goalFatPer, :purpose)
  end  
  
end
