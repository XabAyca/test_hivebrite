require 'rails_helper'

RSpec.describe InitNewUserService do
  subject {
    described_class.call
  }

  it "Initialize a new user with all custom attributes" do
    expect(subject.result.new_record?).to be(true)
    expect(subject.result.class.name).to eq("User")
    expect(subject.result.custom_attributes.length).to be(5)
  end
end
