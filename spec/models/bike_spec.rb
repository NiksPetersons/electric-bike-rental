require "rails_helper"

RSpec.describe Bike, type: :model do
  describe "associations" do
    it { should have_many(:rentals) }
  end

  describe "validations" do
    subject { create(:bike) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "scopes" do
    let!(:active_bike) { create(:bike, name: "Active Bike", active: true) }
    let!(:inactive_bike) { create(:bike, name: "Inactive Bike", active: false) }

    it "returns only active bikes" do
      expect(Bike.active).to include(active_bike)
      expect(Bike.active).not_to include(inactive_bike)
    end
  end

  describe "creating a bike" do
    context "with duplicate name" do
      before { create(:bike, name: "Unique Bike") }

      it "does not save the bike" do
        duplicate_bike = build(:bike, name: "Unique Bike")
        expect(duplicate_bike.save).to be_falsey
      end
    end
  end
end
