class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
      t.belongs_to :user, index:true
      t.belongs_to :catgegory, index:true
      t.timestamps null: false
    end
  end
end
