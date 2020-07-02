class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user
  validates :title, presence: {message: 'Specify a name, please'}, length: {in: 5..40}, uniqueness: true
  validates :description, presence: true, length: {minimum:10, too_short: 'too short. Try giving more details!'}
end
