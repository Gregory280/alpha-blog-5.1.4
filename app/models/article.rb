class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum:5, maximum:200}
  validates :description, presence: true, length: {minimum:10}
end
