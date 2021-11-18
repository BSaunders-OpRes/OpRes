class Notification < ApplicationRecord
  has_many :user_notifications
  belongs_to :notificationable, polymorphic: true
  enum noti_type: { alert: 0, success: 1, notice: 2 }

  after_save :create_user_notifications

  def create_user_notifications
    if self.notificationable_type == 'Release'
      User.all.each do |user|
        UserNotification.create(notification_id: self.id, user_id: user.id)
      end
    end
  end
end
