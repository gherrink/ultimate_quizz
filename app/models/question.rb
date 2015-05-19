class Question < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates :question, :answer_correct, :answer_wrong_1, :answer_wrong_2, :answer_wrong_3, :categories, presence: true
  validates :question, length: { in: 6..255 }
  validates :answer_correct, :answer_wrong_1, :answer_wrong_2, :answer_wrong_3, length: { in: 2..100 }

  def self.question_of_category(category_id, asked_questions, offset)
    # also possible Question.joins(:categories).where(:categories => {:id => category_id}).first(:order => "RANDOM()")
    if(asked_questions.empty?)
      Question.joins(:categories).where(:categories => {:id => category_id}).offset(offset).first
    else
      Question.joins(:categories).where(:categories => {:id => category_id}).where('question_id not in (?)', asked_questions).offset(offset).first
    end
  end

  def self.count_question_of_category(category_id, asked_questions)
    if(asked_questions.empty?)
      Question.joins(:categories).where(:categories => {:id => category_id}).count
    else
      Question.joins(:categories).where(:categories => {:id => category_id}).where('question_id not in (?)', asked_questions).count
    end
  end
end
