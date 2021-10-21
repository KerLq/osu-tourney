class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :mp_link
      t.integer :warmup
      t.decimal :matchcost
      t.bigint :average_score

      t.timestamps
    end
  end
end
