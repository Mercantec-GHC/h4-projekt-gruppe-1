class AddRoundsToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :rounds, :integer, default: 0
  end
end
