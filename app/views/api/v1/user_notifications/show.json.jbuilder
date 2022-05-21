json.extract! @user_notification, :id, :seen
json.notification @user_notification.notification, :id, :title, :description
json.user @user_notification.user, :id, :email
