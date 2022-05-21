class AddSeenToUserNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :user_notifications, :seen, :boolean, default: false
  end
end
