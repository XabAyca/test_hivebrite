require 'rails_helper'

RSpec.describe User, type: :model do
  let(:event) {
    Event.create(
      name: "My event",
      start_date: 10.days.from_now,
      end_date: 12.days.from_now,
    )
  }

  subject {
    described_class.new(
      first_name: "Sarah",
      last_name: "Connor",
      email: "sarah.connor@cant_die.com",
      password: "password"
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is valid with valid without first_name" do
      expect(subject).to be_valid
    end

    it "is valid with valid without last_name" do
      expect(subject).to be_valid
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with existing email" do
      described_class.create(
        email: "sarah.connor@cant_die.com",
        password: "password"
      )
      expect(subject).to_not be_valid
    end
  end

  describe "Relations" do
    let(:custom_attributes_users) {
      CustomAttributes::User.new(
        name: "Attributes",
      )
    }

    let(:registration) {
      Registration.new(
        number: 2,
        event: event
      )
    }

    it "should have many custom_attributes_events" do
      expect(described_class.reflect_on_association(:custom_attributes).macro).to eq :has_many
    end

    it "should have many registrations" do
      subject.save
      registration.user = subject
      registration.save
      expect(described_class.reflect_on_association(:registrations).macro).to eq :has_many
      expect(subject.registrations.count).to eq(1)
    end
  end
end
