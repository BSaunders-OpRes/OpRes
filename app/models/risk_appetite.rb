class RiskAppetite < ApplicationRecord
  belongs_to :business_service_line
  belongs_to :creator, class_name: 'User' ,foreign_key: :creator_id
end
