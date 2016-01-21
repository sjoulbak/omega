class EmployeesController < ApplicationController
  before_action :require_admin
  before_action :set_employee, only: [:edit, :show, :edit, :update, :destroy]

  # This method is used for the index employees page
  def index
    @employees = User.where(admin: true)
  end

  # This method is used for the show employee page
  def show
  end

  # This method is used for the new employee page
  def new
    @employee = User.new
  end

  # This method is used for the edit employee page
  def edit
  end

  # This method will be trigged if there is a post request with the create method
  def create
    @employee = User.new(employee_params).toggle(:admin)

    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created'
    else
      render action: 'new'
    end
  end

  # This method will be trigged if there is a post request with the update method
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        render action: 'edit'
      end
    end
  end

  # This method will be trigged if there is a post request with the destroy method
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_path, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # This method will find an employee with an id param and define the instance variable @employee to it
  def set_employee
    @employee = User.find(params[:id])
  end

  # This method wil require from params the hash user and permit params to have: email, password, password_confirmation
  def employee_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
