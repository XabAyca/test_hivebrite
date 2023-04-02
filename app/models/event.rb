class Event < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true

  has_many :custom_attributes, as: :targetable, dependent: :destroy, class_name: "::CustomAttributes::Event"
  has_many :registrations

  accepts_nested_attributes_for :custom_attributes
end
