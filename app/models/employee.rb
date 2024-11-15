class Employee < ApplicationRecord
  has_many :rentals

  scope :active, -> { where(active: true) }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
    uniqueness: { case_sensitive: false, if: :email_changed? },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    "#{first_name} #{last_name}"
  end
end
