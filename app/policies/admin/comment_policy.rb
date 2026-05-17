module Admin
  class CommentPolicy < ApplicationPolicy
    def index?
      admins_or_moderator?
    end

    def update?
      admins_or_moderator? && record.flag_reason.present?
    end

    def destroy?
      admins_or_moderator?
    end
  end
end
