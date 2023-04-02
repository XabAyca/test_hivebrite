require 'rails_helper'

RSpec.describe InitNewRegistrationService do
  let(:event) {
    Event.create(
      name: "My event",
      start_date: 10.days.from_now,
      end_date: 12.days.from_now,
      custom_attributes_attributes: [
        { name: "Test" },
        { name: "Test1" },
        { name: "Test2" }
      ]
    )
  }

  let(:user) {
    User.create(
      first_name: "John",
      last_name: "Doe",
      password: "password",
      email: "test@test.fr"
    )
  }

  subject {
    described_class.call(
      user: user,
      event: event
    )
  }

  it "Initialize a new registration with all custom attributes" do
    expect(subject.result.new_record?).to be(true)
    expect(subject.result.class.name).to eq("Registration")
    expect(subject.result.custom_attributes.length).to be(3)
  end
end
