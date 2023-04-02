module CustomAttributes
  class Registration < ::CustomAttribute
    validates :value, presence: true, on: :create, if: :required_create
  end
end
