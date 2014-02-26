class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :name
      t.integer :score
      t.integer :game_id

      t.timestamps
    end
  end
end
