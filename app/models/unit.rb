class Unit < ApplicationRecord
  # Modules #
  include Firm::CountryConcern

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
  # has_many :unit_level_products

  # Validations #
  # validates :name, presence: true

  # Enums #
  enum unit_type: %i[retail investment insurance other]

  # Methods #
  def inclusive_children
    exclusive_children.unshift(self)
  end

  def exclusive_children
    children.flat_map do |child|
      child.exclusive_children << child
    end
  end

  def find_children(child_id)
    inclusive_children.select { |child| child.id == child_id }.first
  end

  def sort_children_rule
    case type
    when 'Units::Organisational'
      0
    when 'Units::Regional'
      1
    when 'Units::Country'
      2
    when 'Units::Institution'
      3
    end
  end

  class << self
    def sort_children(children_nodes)
      children_nodes.sort_by(&:sort_children_rule)
    end
  end
end
