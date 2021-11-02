class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.string :description
      t.string :cover_image
      
      t.timestamps
    end
  end
end
