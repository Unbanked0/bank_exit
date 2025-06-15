module Admin
  class CommentPolicy < ApplicationPolicy
    def index?
      true
    end

    def update?
      destroy?
    end

    def destroy?
      record.flag_reason.present?
    end
  end
end
