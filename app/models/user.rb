class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :articles
  validates :username, presence: true, length: {minimun: 3, maximum: 20}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100}, format: {with: VALID_EMAIL_REGEX}
end