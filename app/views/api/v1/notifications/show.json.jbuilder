json.extract! @notification, :id, :date, :title, :description
json.user_notifications @notification.user_notifications do |user_notification|
  json.extract! user_notification, :id, :seen, :user_id
  json.extract! user_notification.user, :email
end
