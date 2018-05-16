class Api::V1::ApiController < ::ApplicationController
    # ApplicationControllerでauthenticate_userを呼び出している場合、
    # ここでも処理がはしり、401エラーの元なので、切っておく
    before_action :authenticate_user!, only: []

    private
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
end