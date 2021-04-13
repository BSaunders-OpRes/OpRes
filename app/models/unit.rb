class Unit < ApplicationRecord
  belongs_to :user

  has_many :key_contacts
  has_many :supplier_contacts
  has_many :products
  has_many :channels
  has_many :suppliers
  has_many :business_service_lines
end
