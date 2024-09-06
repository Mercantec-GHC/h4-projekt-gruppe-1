class AddDrawToUserStats < ActiveRecord::Migration[7.1]
  def change
    add_column :user_stats, :draw, :integer, default: 0
  end
end
