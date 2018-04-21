class TalksController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /talks
  def create
    Rails.logger.info params
  end
end