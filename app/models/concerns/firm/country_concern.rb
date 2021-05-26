module Firm::CountryConcern
  extend ActiveSupport::Concern

  included do
    class << self
    end
  end
end
