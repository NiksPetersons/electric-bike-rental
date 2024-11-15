class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update deactivate]

  def index
    @employees = Employee.active
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to employees_path, notice: t("employees.notices.successfully_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: t("employees.notices.successfully_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def deactivate
    if @employee.update(active: false)
      redirect_to employees_path, notice: t("employees.notices.successfully_deactivated")
    else
      redirect_to employees_path, alert:  t("employees.notices.unsuccessfully_deactivated")
    end
  end

  private

  def set_employee
    @employee ||= Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email)
  end
end
