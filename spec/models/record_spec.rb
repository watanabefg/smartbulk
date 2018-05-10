require 'rails_helper'

describe Record, type: :model do                    # Record モデルについて記述（describe）する
  it "is valid with a user_id and weight and fatPer" do # user_id と weight と fatPer を保持していることが正である
    user = User.new(
        name: 'test',
        email: 'google@gmail.com',
        password_digest: 'f2j303jfef',
        goalWeight: 49.5,
        goalFatPer: 10.0,
        purpose: 'test'
        )
    user.save
        record = Record.new(
            user_id: 1,
            weight: 65.3,
            fatPer: 12.1
        )
        expect(record).to be_valid
    
  end
  it "is invalid without a user_id"      # user_id が無いと無効である
  it "is invalid without a weight"      # weight が無いと無効である
  it "is invalid without a fatPer"      # fatPer が無いと無効である
end