class RemoveSeenFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :seen, :boolean
  end
end
