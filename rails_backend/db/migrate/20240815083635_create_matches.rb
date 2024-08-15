class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.string :winner
      t.string :loser
      t.integer :player_1_points
      t.integer :player_2_points

      t.timestamps
    end
  end
end
