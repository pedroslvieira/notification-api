class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.order('notifications.id ASC') if user.try(:admin?)
      # to show only notif of user
      # scope.where(user: user)
    end
  end

  def index?
    user.admin
  end

  def show?
    index?
  end

  def update?
    index?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
