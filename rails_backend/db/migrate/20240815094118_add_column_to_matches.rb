class AddColumnToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :draw, :boolean
  end
end
