class Units::Regional < Unit
  class << self
    def build_name(parent, region)
      "#{parent.name} #{region}"
    end
  end
end
