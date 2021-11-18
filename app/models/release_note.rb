class ReleaseNote < ApplicationRecord
  belongs_to :release
  enum title: { feature: 0, bugfix: 1, upgrades: 2, general_note: 3 }
end
