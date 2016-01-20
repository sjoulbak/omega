class Course < ActiveRecord::Base
  validates :begindatum, :einddatum, :soortcourse, presence: true
  belongs_to :soortcourse

  has_many :course_users, dependent: :destroy
  has_many :users, -> { distinct }, through: :course_users
end
