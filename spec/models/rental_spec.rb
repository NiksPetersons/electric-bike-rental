require "rails_helper"

RSpec.describe Rental, type: :model do
  describe "associations" do
    it { should belong_to(:bike) }
    it { should belong_to(:employee) }
  end

  describe "validations" do
    subject { create(:rental) }

    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it "validates that end_time is after start_time" do
      rental = build(:rental, start_time: Time.current, end_time: Time.current - 1.hour)
      expect(rental).not_to be_valid
      expect(rental.errors[:end_time]).to include("nevar būt vienāds vai pirms sākuma laika")  # Adjust this message based on your validation
    end

    it "validates bike availability" do
      bike = create(:bike)
      create(:rental, bike: bike, start_time: Time.current, end_time: Time.current + 1.hour)
      rental = build(:rental, bike: bike, start_time: Time.current, end_time: Time.current + 1.hour)
      expect(rental).not_to be_valid
      expect(rental.errors[:bike]).to include("nav pieejams norādītajā laikā")  # Adjust this message based on your validation
    end
  end
end
