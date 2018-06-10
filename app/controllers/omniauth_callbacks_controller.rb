class OmniauthCallbacksController < ApplicationController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  def doorkeeper
    @user = User.find_for_doorkeeper(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'doorkeeper'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.doorkeeper_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url, alert: @user.errors
    end 
  end 
end
