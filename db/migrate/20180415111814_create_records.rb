class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.datetime :date
      t.float :weight
      t.float :fatPer

      t.timestamps
    end
  end
end
