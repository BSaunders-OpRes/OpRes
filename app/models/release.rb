class Release < ApplicationRecord
  has_many :release_notes
  has_many :notifications, as: :notificationable

  after_save :create_notifications

  def create_notifications
    Notification.create(title: self.title, notificationable_type: 'Release', notificationable_id: self.id)
  end

  def get_notification
    notifications.first
  end
end
