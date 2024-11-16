require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "associations" do
    it { should have_many(:rentals) }
  end

  describe "validations" do
    subject { create(:employee) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value("example@email.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email) }
  end

  describe "full_name method" do
    subject { create(:employee, first_name: "Jānis", last_name: "Vītiņš") }

    it "returns the full name of the employee" do
      expect(subject.full_name).to eq("Jānis Vītiņš")
    end
  end
end
