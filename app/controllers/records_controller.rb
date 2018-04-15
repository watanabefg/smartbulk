class RecordsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to root_url
    else
      @records = current_user.records.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @record.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def record_params
    params.require(:record).permit(:weight, :fatPer)
  end

  def correct_user
    @record = current_user.records.find_by(id: params[:id])
    unless @record
      redirect_to root_url
    end
  end  
end
