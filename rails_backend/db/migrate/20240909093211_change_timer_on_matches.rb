class ChangeTimerOnMatches < ActiveRecord::Migration[7.1]
  def change
    change_column_default :matches, :timer, from: 0, to: 60
  end
end
