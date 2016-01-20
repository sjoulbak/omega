class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :course_users, dependent: :destroy
  has_many :courses, -> { distinct }, through: :course_users

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true, presence: true
end
