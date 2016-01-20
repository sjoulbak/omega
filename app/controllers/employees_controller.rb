class EmployeesController < ApplicationController
  before_action :require_admin
  before_action :set_employee, only: [:edit, :show, :edit, :update, :destroy]

  def index
    @employees = User.where(admin: true)
  end

  def show
  end

  def new
    @employee = User.new
  end

  def edit
  end

  def create
    @employee = User.new(employee_params).toggle(:admin)

    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created'
    else
      render action: 'new'
    end
  end

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

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_path, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_employee
    @employee = User.find(params[:id])
  end

  def employee_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
