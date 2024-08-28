class AddPlayerCommentsToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :player_1_comment, :string
    add_column :matches, :player_2_comment, :string
  end
end
