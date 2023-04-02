class Registration < ApplicationRecord
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :user
  belongs_to :event
  has_many :custom_attributes, as: :targetable, dependent: :destroy, class_name: "::CustomAttributes::Registration"

  accepts_nested_attributes_for :custom_attributes
end
