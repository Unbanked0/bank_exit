module Admin
  module Merchants
    class BatchActionPolicy < ApplicationPolicy
      def update?
        destroy?
      end

      def destroy?
        true
      end
    end
  end
end
