module Admin
  module Merchants
    class DirectoryConverterPolicy < ApplicationPolicy
      def create?
        !Directory.exists?(merchant_id: record.id)
      end
    end
  end
end
