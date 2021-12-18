class AddTwitterToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :twitter, :string
  end
end
