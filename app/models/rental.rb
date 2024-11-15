class Rental < ApplicationRecord
  belongs_to :employee
  belongs_to :bike

  scope :active, -> { where(canceled: false) }
  scope :by_date_range, ->(start_date, end_date) { where(start_time: start_date.beginning_of_day..end_date.end_of_day) }

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :bike_availability

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, I18n.t("activerecord.errors.messages.cant_be_before")) if end_time <= start_time
  end

  def bike_availability
    return if bike_id.blank? || start_time.blank? || end_time.blank? || canceled?

    overlapping_rentals = Rental.active.where(bike_id: bike_id)
                                 .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping_rentals.exists?
      errors.add(:bike, I18n.t("activerecord.errors.messages.not_available"))
    end
  end
end
