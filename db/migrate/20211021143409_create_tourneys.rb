class CreateTourneys < ActiveRecord::Migration[6.1]
  def change
    create_table :tourneys do |t|

      t.timestamps
    end
  end
end
