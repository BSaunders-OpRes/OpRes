class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.integer :noti_type, default: 2
      t.string :notificationable_type
      t.bigint :notificationable_id

      t.timestamps
    end
  end
end
