json.array! @user_notifications do |user_notification|
  json.extract! user_notification, :id, :seen, :user_id, :notification_id
end
