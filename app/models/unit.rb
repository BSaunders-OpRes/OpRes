class Unit < ApplicationRecord
  # Modules #
  include Firm::CountryConcern
  include Firm::ChildrenConcern
  include Firm::DropdownConcern

  # Associations #
  belongs_to :parent, class_name: 'Unit', foreign_key: :parent_id,  optional: true
  belongs_to :region,      optional: true
  belongs_to :country,     optional: true
  belongs_to :institution, optional: true

  has_many :children, class_name: 'Unit', foreign_key: :parent_id
  has_many :managers, dependent: :destroy
  has_many :managing_users, through: :managers, source: :user
  has_many :users
  has_many :key_contacts
  has_many :supplier_contacts
  has_many :suppliers
  has_many :business_service_lines
  has_many :institutions, dependent: :destroy
  has_many :products
  has_many :channels
  has_many :unit_products, dependent: :destroy
  has_many :unit_level_products, through: :unit_products, source: :product

  # Validations #
  # validates :name, presence: true

  # Enums #
  enum unit_type: %i[bank building_society insurer designated_investment_firm payments_services_institution recognised_investment_exchange electronic_money_institution enhanced_scope_senior_managers_and_certification_regime]

  # Methods #
  class << self
    def build_name(prefix, name, postfix)
      "#{prefix} #{name} #{postfix}".squish
    end
  end

  %w[organisational_unit regional_unit country_unit institution_unit].each do |klass|
    define_method "#{klass}?" do
      self.class.name.downcase.include? klass.split('_').first
    end
  end
end
