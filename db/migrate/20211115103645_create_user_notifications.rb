class CreateUserNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_notifications do |t|
      t.integer :notification_id
      t.integer :user_id
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
