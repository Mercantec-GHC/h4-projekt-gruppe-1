class CreateJoinTableMatchesUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :matches, :users do |t|
      t.index [:match_id, :user_id]
      t.index [:user_id, :match_id]
    end
  end
end
