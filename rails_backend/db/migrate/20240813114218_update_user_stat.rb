class UpdateUserStat < ActiveRecord::Migration[7.1]
  def change
    change_table :user_stats do |t|
      t.integer :user_id
    end
  end
end
