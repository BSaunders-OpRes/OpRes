class Bsl::BaseService < ApplicationService
  def initialize(args)
    @args                = args

    @data = {}
  end
end
