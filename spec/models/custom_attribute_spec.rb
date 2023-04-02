require 'rails_helper'

RSpec.describe CustomAttribute, type: :model do
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
      name: "Specific attribute",
      value: "value",
      required_create: false,
      required_update: false,
      targetable: user
    )
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is valid with valid without value and no required" do
      subject.value = nil
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without targetable" do
      subject.targetable = nil
      expect(subject).to_not be_valid
    end

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

    it "is not valid with existing name" do
      described_class.create(
        name: "Specific attribute",
        targetable: user
      )
      expect(subject).to_not be_valid
    end
  end

  describe "Methods" do
    describe "#value= and #value" do
      it "can save boolean(false) and return same" do
        subject.value = false
        subject.save
        expect(subject.value).to eq(false)
      end

      it "can save boolean(true) and return same" do
        subject.value = true
        subject.save
        expect(subject.value).to eq(true)
      end

      it "can save string and return same string" do
        subject.save
        expect(subject.value).to eq("value")
      end
    end
  end

  describe "Relations" do
    describe "belongs_to :targetable" do
      it "can be an user" do
        subject.save
        expect(subject.targetable).to be(user)
        expect(subject.targetable_type).to eq("User")
      end

      it "can be an event" do
        subject.targetable = event
        subject.save
        expect(subject.targetable).to be(event)
        expect(subject.targetable_type).to eq("Event")
      end
    end
  end
end
