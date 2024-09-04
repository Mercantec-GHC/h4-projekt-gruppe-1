class AddTimerToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :timer, :integer, default: 0
  end
end
