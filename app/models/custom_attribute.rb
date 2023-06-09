class CustomAttribute < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :targetable, presence: true, if: :need_targetable?

  belongs_to :targetable, polymorphic: true, optional: true

  def need_targetable?
    true
  end

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
