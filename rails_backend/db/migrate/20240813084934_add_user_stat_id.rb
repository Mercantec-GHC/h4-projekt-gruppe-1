class AddUserStatId < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.belongs_to :user_stat, foreign_key: true
    end
  end
end
