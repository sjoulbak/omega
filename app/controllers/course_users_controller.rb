class CourseUsersController < ApplicationController
  def create
    @course = Course.find course_users_params[:course_id]
    @course_user = CourseUser.new(course: @course, user: current_user)
    if @course_user.save
      redirect_to course_path(@course)
    else
      CourseUser.where(course: @course, user: current_user).destroy_all
      redirect_to course_path(@course)
    end
  end

  private

  def course_users_params
    params.permit(:course_id)
  end
end
