class User < ApplicationRecord
  has_many :units

  enum role: %i[org_admin unit_admin user]
end
