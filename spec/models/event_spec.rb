require 'rails_helper'

RSpec.describe Event, type: :model do
  subject {
    described_class.new(
      name: "Super New Event",
      start_date: 10.days.from_now,
      end_date: 12.days.from_now,
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a start_date" do
      subject.start_date = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a end_date" do
      subject.end_date = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Relations" do
    it "should have many custom_attributes_events" do
      expect(described_class.reflect_on_association(:custom_attributes).macro).to eq :has_many
    end
  end
end
