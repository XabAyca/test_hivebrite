require 'rails_helper'

RSpec.describe Registration, type: :model do
  let(:user) {
    User.create(
      first_name: "John",
      last_name: "Doe",
      password: "password",
      email: "test@test.fr"
    )
  }

  let(:event) {
    Event.create(
      name: "My event",
      start_date: 10.days.from_now,
      end_date: 12.days.from_now,
    )
  }

  subject {
    described_class.new(
      number: 1,
      user: user,
      event: event
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without number" do
      subject.number = nil
      expect(subject).to_not be_valid
    end

    it "is not valid wit number lower than 1" do
      subject.number = 0
      expect(subject).to_not be_valid
    end

    it "is not valid without event" do
      subject.event = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Relations" do
    let(:custom_attributes_registrations) {
      CustomAttributes::Registration.new(
        name: "Attributes",
      )
    }

    it "should have many custom_attributes_registrations" do
      subject.save
      custom_attributes_registrations.targetable = subject
      custom_attributes_registrations.save
      expect(described_class.reflect_on_association(:custom_attributes).macro).to eq(:has_many)
      expect(subject.custom_attributes.count).to eq(1)
    end

    it "should have one user" do
      subject.save
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(subject.user).to be(user)
    end

    it "should have one event" do
      subject.save
      expect(described_class.reflect_on_association(:event).macro).to eq(:belongs_to)
      expect(subject.event).to be(event)
    end

    it "should create custom_attributes_registrations with nested attributes" do
      attrs = {
        number: 1,
        user: user,
        event: event,
        custom_attributes_attributes: [
          {
            name: "Test"
          }
        ]
      }
      subject.assign_attributes(attrs)
      subject.save
      expect(CustomAttributes::Registration.where(targetable: subject).count).to eq(1)
    end
  end
end
