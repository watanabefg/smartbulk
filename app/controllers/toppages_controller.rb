class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @record = current_user.records.build  # form_for 用
      @records = current_user.records.order('created_at DESC').page(params[:page])
    end
  end
end
