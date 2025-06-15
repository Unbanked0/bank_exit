module Admin
  class DirectoryPolicy < ApplicationPolicy
    def index?
      true
    end

    def new?
      create?
    end

    def create?
      true
    end

    def edit?
      update?
    end

    def update?
      destroy?
    end

    def destroy?
      true
    end

    def update_position?
      update?
    end
  end
end
