class BikesController < ApplicationController
  before_action :set_bike, only: %i[edit update deactivate]

  def index
    @bikes = Bike.active
  end

  def new
    @bike = Bike.new
  end

  def edit
  end

  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      redirect_to bikes_path, notice: t("bikes.notices.successfully_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bike.update(bike_params)
      redirect_to bikes_path, notice: t("bikes.notices.successfully_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def deactivate
    if @bike.update(active: false)
      redirect_to bikes_path, notice: t("bikes.notices.successfully_deactivated")
    else
      redirect_to bikes_path, alert: t("bikes.notices.unsuccessfully_deactivated")
    end
  end

  private

  def set_bike
    @bike ||= Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:name)
  end
end
