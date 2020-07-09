class Comment < ApplicationRecord
  validates :comment, presence: {message: "Can't be blank"}, length: {in: 1..400}
  belongs_to :article
  belongs_to :user
end
