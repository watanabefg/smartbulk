module Api::V1
  class CredentialsController < ApiController
    # loginメソッドを外部から呼び出す際にdoorkeeperで認証処理する
    before_action :doorkeeper_authorize!

    # ユーザーのデータをjson形式で送る
    def me
      render json: { user: current_resource_owner }
    end
  end
end