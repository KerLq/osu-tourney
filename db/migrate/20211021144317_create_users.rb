class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.integer :user_id

      t.references :tourney, foreign_key: true
      t.timestamps
    end
  end
end
