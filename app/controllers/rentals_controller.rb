class RentalsController < ApplicationController
  before_action :set_employees_and_bikes, only: [ :new, :create ]

  def index
    @rentals = Rental.includes(:employee, :bike).active
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to rentals_path, notice: t("rentals.notices.successfully_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    rental = Rental.find(params[:id])

    if rental.update(canceled: true)
      redirect_to rentals_path, notice: t("rentals.notices.successfully_canceled")
    else
      redirect_to rentals_path, alert: t("rentals.notices.unsuccessfully_canceled")
    end
  end

  def export
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    export_service = RentalExportService.new(start_date, end_date)

    data = export_service.generate_csv

    respond_to do |format|
      format.csv { send_data data, filename: "rentals-#{start_date}-to-#{end_date}.csv" }
    end
  end

  private

  def set_employees_and_bikes
    @employees ||= Employee.active
    @bikes ||= Bike.active
  end

  def rental_params
    params.require(:rental).permit(:employee_id, :bike_id, :start_time, :end_time)
  end
end
