class Organisation::BaseController < ApplicationController
  # authenticate and authorize user.
  before_action :load_organisational_unit

  attr_reader :organisational_unit

  layout 'organisation'

  private

  def load_organisational_unit
    @organisational_unit = current_user.unit
  end
end
