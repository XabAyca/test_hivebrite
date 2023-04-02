require 'rails_helper'

RSpec.describe User, type: :model do
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
    it "should have many custom_attributes_events" do
      expect(described_class.reflect_on_association(:custom_attributes).macro).to eq :has_many
    end
  end
end
