require 'rails_helper'

RSpec.describe ::CustomAttributes::UserTemplate, type: :model do
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

  describe "Relations" do
    it "is valid without targetable" do
      subject.targetable = nil
      expect(subject).to be_valid
    end
  end
end
