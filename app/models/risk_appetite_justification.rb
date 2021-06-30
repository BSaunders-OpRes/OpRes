class RiskAppetiteJustification < ApplicationRecord
  # Associations #
  belongs_to :risk_appetite
  belongs_to :user

  # Scopes #
  default_scope { order(id: :asc) }

  # Methods #
  def creation_info
    "Justification Created By #{user.name} on #{strf_created_at} (UTC)"
  end

  def modification_info
    "Most Recent Modification: #{user.name} on #{strf_created_at} (UTC)"
  end

  def strf_created_at
    created_at.strftime('%d %b %Y at %H:%M %p')
  end
end
