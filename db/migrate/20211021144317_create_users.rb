class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.int :user_id

      t.timestamps
    end
  end
end
