class CreateScores < ActiveRecord::Migration[7.2]
  def change
    create_table :scores do |t|
      t.references :user, index: true, foreign_key: true
      t.references :challenge, index: true, foreign_key: true
      t.integer :right
      t.integer :wrong
      t.integer :timed_out

      t.timestamps
    end
  end
end
