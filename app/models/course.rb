class Course < ActiveRecord::Base
  belongs_to :soortcourse

  has_many :course_users, dependent: :destroy
  has_many :users, -> { distinct }, through: :course_users
end
