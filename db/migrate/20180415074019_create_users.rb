class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :goalWeight
      t.integer :goalFatPer
      t.string :purpose

      t.timestamps
    end
  end
end
