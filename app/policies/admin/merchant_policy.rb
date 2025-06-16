module Admin
  class MerchantPolicy < ApplicationPolicy
    def show?
      true
    end

    def update?
      destroy?
    end

    def destroy?
      record.deleted_at.present?
    end
  end
end
