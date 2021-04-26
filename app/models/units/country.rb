class Units::Country < Unit
  class << self
    def build_name(organization,country)
      "#{organization.name} #{country}"
    end
  end
end
