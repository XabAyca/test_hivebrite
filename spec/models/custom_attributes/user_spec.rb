require 'rails_helper'

RSpec.describe CustomAttributes::User, type: :model do
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
      name: "Specific attribute",
      value: "value",
      required_create: false,
      required_update: false,
      targetable: user
    )
  }

  describe "Validations" do
    it "is not valid on create with required_create true and without value" do
      subject.required_create = true
      subject.value = nil
      expect(subject).to_not be_valid
    end

    it "is not valid on update with required_update true and without value" do
      subject.save
      subject.required_update = true
      subject.value = nil
      expect(subject).to_not be_valid
    end

    it "is valid on update with required_create true and without value" do
      subject.save
      subject.required_update = true
      expect(subject).to be_valid
    end

    it "is valid on create with required_update true and without value" do
      subject.required_update = true
      subject.value = nil
      expect(subject).to be_valid
    end
  end
end
