class Category < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :scores

  validates :name, presence: true, uniqueness: true, length: { in: 2..100 }
end
