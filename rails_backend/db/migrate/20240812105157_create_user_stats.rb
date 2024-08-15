class CreateUserStats < ActiveRecord::Migration[7.1]
  def change
    create_table :user_stats do |t|
      t.integer :wins
      t.integer :lost
      t.integer :skips
      t.integer :games_played
      t.integer :right_guesses

      t.timestamps
    end
  end
end
