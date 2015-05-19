class Question < ActiveRecord::Base
  has_and_belongs_to_many :categories

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
