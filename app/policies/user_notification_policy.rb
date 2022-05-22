class UserNotificationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.try(:admin?)
        scope.all.order('user_notifications.id ASC')
      else
        scope.where(user: user).order('user_notifications.id ASC')
      end
    end
  end

  def show?
    record.user == user || user.admin
  end

  def create?
    user.admin
  end

  def destroy?
    create?
  end
end
