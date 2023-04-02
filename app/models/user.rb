class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :custom_attributes, as: :targetable, dependent: :destroy, class_name: "::CustomAttributes::User"
  has_many :registrations

  accepts_nested_attributes_for :custom_attributes
end
