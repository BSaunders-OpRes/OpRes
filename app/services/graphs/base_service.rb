class Graphs::BaseService < ApplicationService
  def initialize(args)
    @args                = args
    @current_user        = args.dig('current_user')
    @organisational_unit = args.dig('organisational_unit')

    @data = {}
  end

  attr_reader :current_user, :organisational_unit, :data
end
