class Api::V1::CredentialsController < Api::V1::ApiController
    # loginメソッドを外部から呼び出す際にdoorkeeperで認証処理する
    before_action :doorkeeper_authorize!
    respond_to :json

    # ユーザーのデータをjson形式で送る
    def me
      render current_resource_owner
    end
end