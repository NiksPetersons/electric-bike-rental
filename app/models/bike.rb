class Bike < ApplicationRecord
  has_many :rentals

  scope :active, -> { where(active: true) }

  validates :name, presence: true, uniqueness: true
end
