require "csv"
require "abstract_controller/translation"

class RentalExportService
  include AbstractController::Translation

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def generate_csv
    rentals = Rental.active.by_date_range(@start_date, @end_date)
    CSV.generate(headers: true) do |csv|
      csv << [ t("rentals.employee_name"), t("rentals.bike_name"), t("rentals.start_time"), t("rentals.end_time") ]
      rentals.each do |rental|
        csv << [ rental.employee.full_name, rental.bike.name, rental.start_time, rental.end_time ]
      end
    end
  end
end
