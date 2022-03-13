class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :title, default: 0

      t.integer :user_id, foreign_key: true
      t.timestamps
    end
  end
end
