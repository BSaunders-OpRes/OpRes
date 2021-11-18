class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  def viewed!
    self.update(viewed: true)
  end
end
