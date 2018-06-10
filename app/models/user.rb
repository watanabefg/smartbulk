class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
  before_save { self.email.downcase! }
  validates :name, presence: false, length: { maximum: 50 }
  validates :email, presence: false, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_many :records

  # Twitterのログイン情報を取得し、まだ未登録であればユーザー登録する
  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        :provider => auth.provider,
        :uid => auth.uid,
        :email => User.dummy_email(auth),
        :password =>  Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end
  
  # dummyのemailを生成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  
  def self.find_for_doorkeeper(auth)
    parameters = { 
      name:     auth.info.name,
      email:    auth.info.email,
      provider: auth.provider,
      uid:      auth.uid,
      token:    auth.credentials.token,
      password: Devise.friendly_token[0, 20]
      #raw: auth.extra.to_json
    }
    user = User.find_by(uid: auth.uid)
    return update_mock!(user, parameters) if user

    User.create(parameters)
  end 

  def self.update_mock!(user, parameters)
    user.update(parameters)
    user
  end 
end
