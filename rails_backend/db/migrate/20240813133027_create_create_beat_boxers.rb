class CreateCreateBeatBoxers < ActiveRecord::Migration[7.1]
  def change
    create_table :beat_boxers do |t|
      t.string :name

      t.timestamps
    end
  end
end
