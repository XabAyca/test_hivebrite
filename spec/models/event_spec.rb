require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) {
    User.create(
      first_name: "John",
      last_name: "Doe",
      password: "password",
      email: "test@test.fr"
    )
  }

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
    let(:custom_attributes_events) {
      CustomAttributes::Event.new(
        name: "Attributes",
      )
    }

    let(:registration) {
      Registration.new(
        number: 2,
        user: user
      )
    }

    it "should have many custom_attributes_events" do
      subject.save
      custom_attributes_events.targetable = subject
      custom_attributes_events.save
      expect(described_class.reflect_on_association(:custom_attributes).macro).to eq :has_many
      expect(subject.custom_attributes.count).to eq(1)
    end

    it "should have many registrations" do
      subject.save
      registration.event = subject
      registration.save
      expect(described_class.reflect_on_association(:registrations).macro).to eq :has_many
      expect(subject.registrations.count).to eq(1)
    end
  end
end
