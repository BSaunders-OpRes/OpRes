class SubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && %w[public www].exclude?(request.subdomain)
  end
end
