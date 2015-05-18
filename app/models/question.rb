class Question < ActiveRecord::Base
  has_and_belongs_to_many :categories

  def self.question_of_category(category_id)
    Question.joins(:categories).where(:categories => {:id => category_id}).limit(1)
  end
end
