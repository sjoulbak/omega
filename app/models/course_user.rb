class CourseUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :course, scope: :user_id
  validates_uniqueness_of :user, scope: :course_id
end
