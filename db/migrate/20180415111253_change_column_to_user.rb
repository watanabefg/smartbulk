class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  # 変更内容
  def up
    change_column :users, :goalWeight, :float
    change_column :users, :goalFatPer, :float
  end

  # 変更前の状態
  def down
    change_column :users, :goalWeight, :integer
    change_column :users, :goalFatPer, :integer
  end
end
