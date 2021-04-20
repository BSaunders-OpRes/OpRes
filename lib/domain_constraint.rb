class DomainConstraint
  def self.matches?(request)
    request.subdomain.blank? || %w[public www].include?(request.subdomain)
  end
end
