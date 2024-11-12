class Rental < ApplicationRecord
  belongs_to :bike
  belongs_to :employee
end
