class AddPlayerUserNamesToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :player_1_user_name, :string
    add_column :matches, :player_2_user_name, :string
  end
end
