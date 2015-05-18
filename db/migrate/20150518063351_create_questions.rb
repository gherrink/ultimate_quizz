class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer_correct
      t.string :answer_wrong_1
      t.string :answer_wrong_2
      t.string :answer_wrong_3

      t.timestamps null: false
    end

    create_table :categories_questions, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :question, index: true
    end
  end
end
