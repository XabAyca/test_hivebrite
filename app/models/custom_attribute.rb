class CustomAttribute < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :value, presence: true, on: :create, if: :required_create
  validates :value, presence: true, on: :update,  if: :required_update

  belongs_to :targetable, polymorphic: true

  def value
    case self[:value]
    when "1_b" then true
    when "0_b" then false
    else
      self[:value]
    end
  end

  def value=(val)
    self[:value] =
      if val.is_a?(TrueClass) || val.is_a?(FalseClass)
        val ? "1_b" : "0_b"
      else
        val
      end
  end
end
