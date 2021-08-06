class Graphs::BaseService < ApplicationService
  def initialize(args)
    @args                = args
    @current_user        = args.dig('current_user')
    @organisational_unit = args.dig('organisational_unit')

    @data = {}
  end

  def find_score_and_status_for_percentage(bsl_point,  supplier_point, impact_tolerance_point)
    if(supplier_point == bsl_point || supplier_point > bsl_point)
      %w(10 match)
    elsif (supplier_point < bsl_point && supplier_point >= impact_tolerance_point)
      %w(5 meet)
    elsif (supplier_point < impact_tolerance_point)
      %w(0 exceed)
    end
  end

  def find_score_and_status_for_time(bsl_point,  supplier_point, impact_tolerance_point)
    if (supplier_point == bsl_point)
      %w(10 match)
    elsif (supplier_point < bsl_point && (supplier_point >= impact_tolerance_point && supplier_point < bsl_point))
      %w(5  meet)
    elsif (supplier_point > bsl_point)
      %w(0 exceed)
    end
  end

  attr_reader :current_user, :organisational_unit, :data
end
