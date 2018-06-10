class Api::V1::ApiController < ::ApplicationController
    # ApplicationControllerでauthenticate_userを呼び出している場合、
    # ここでも処理がはしり、401エラーの元なので、切っておく
    # before_action :authenticate_user!, only: []
    
    def access_token
      return @access_token if defined?(@access_token)
      config = Devise.omniauth_configs[:doorkeeper]
      strategy = config.strategy_class.new(*config.args)
      token = session[:doorkeeper_token]
      @access_token = OAuth2::AccessToken.new(strategy.client, token)
    end

    private
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
end