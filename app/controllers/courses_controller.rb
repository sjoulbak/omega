class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :new, :create, :update, :destroy]
  skip_before_action :require_login, only: [:show, :index]

  # This method is used for the index courses page
  def index
    @courses = Course.all
  end

  # This method is used for the new course page
  def new
    @course = Course.new
  end

  # This method is used for the edit course page
  def edit
  end

  # This method is used for the show course page
  def show
  end

  # This method will be trigged if there is a post request with the create method
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created'
    else
      render action: 'new'
    end
  end

  # This method will be trigged if there is a post request with the update method
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        render action: 'edit'
      end
    end
  end

  # This method will be trigged if there is a post request with the destroy method
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # This method will find a course with an id param and define the instance variable @course to it
  def set_course
    @course = Course.find(params[:id])
  end

  # This method wil require from params the hash course and permit params to have: begindatum, einddatum, soortcourse_id
  def course_params
    params.require(:course).permit(:begindatum, :einddatum, :soortcourse_id)
  end
end
