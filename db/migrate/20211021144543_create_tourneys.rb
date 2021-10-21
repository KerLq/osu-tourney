class CreateTourneys < ActiveRecord::Migration[6.1]
  def change
    create_table :tourneys do |t|
      t.string :title
      t.string :spreadsheet

      t.references :match, foreign_key: true
      t.timestamps
    end
  end
end
