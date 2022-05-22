json.extract! @user_notification, :id, :seen, :user_id
json.notification @user_notification.notification, :id, :title, :description
json.user @user_notification.user, :id, :email
