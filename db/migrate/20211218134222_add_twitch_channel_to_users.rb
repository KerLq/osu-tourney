class AddTwitchChannelToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :twitch_channel, :string
  end
end
