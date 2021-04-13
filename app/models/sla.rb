class Sla < ApplicationRecord
  belongs_to :slaable, polymorphic: true
end
