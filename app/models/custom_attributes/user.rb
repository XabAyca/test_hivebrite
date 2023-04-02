module CustomAttributes
  class User < ::CustomAttribute
    validates :value, presence: true, on: :create, if: :required_create
    validates :value, presence: true, on: :update,  if: :required_update
  end
end
