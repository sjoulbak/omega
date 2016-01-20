class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :new, :create, :update, :destroy]
  skip_before_action :require_login, only: [:show, :index]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def show
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created'
    else
      render action: 'new'
    end
  end

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

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:begindatum, :einddatum, :soortcourse_id)
  end
end
