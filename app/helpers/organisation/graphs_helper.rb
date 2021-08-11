module Organisation::GraphsHelper
  def identify_impact_color(status)
    case status
      when 'match'
        'bg-primary-green'
      when 'meet'
        'bg-dark-yellow'
      when 'exceed'
        'red'
      end
  end
end
