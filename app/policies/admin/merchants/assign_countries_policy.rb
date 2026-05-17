module Admin
  module Merchants
    class AssignCountriesPolicy < ApplicationPolicy
      pre_check :require_admins!

      def create?
        true
      end
    end
  end
end
