class Unit < ApplicationRecord
  # Modules #
  include Firm::CountryConcern
  include Firm::ChildrenConcern

  # Associations #
  belongs_to :parent,  class_name: 'Unit', foreign_key: :parent_id,  optional: true
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true
  belongs_to :institution, optional: true

  has_many :children, class_name: 'Unit', foreign_key: :parent_id
  has_many :users
  has_many :key_contacts
  has_many :supplier_contacts
  has_many :suppliers
  has_many :business_service_lines
  has_many :institutions
  has_many :products
  has_many :channels
  has_many :unit_products
  has_many :unit_level_products, through: :unit_products, source: :product

  # Validations #
  # validates :name, presence: true

  # Enums #
  enum unit_type: %i[bank building_society insurer designated_investment_firm payments_services_institution recognised_investment_exchange electronic_money_institution enhanced_scope_senior_managers_and_certification_regime]

  # Methods #
  class << self
    def build_name(organisation, postfix)
      "#{organisation.name} #{postfix}"
    end
  end

  %w[organisational regional country institution].each do |klass|
    define_method "#{klass}?" do
      self.class.name.downcase.include? klass
    end
  end
end
