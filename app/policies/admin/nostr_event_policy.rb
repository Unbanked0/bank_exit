module Admin
  class NostrEventPolicy < ApplicationPolicy
    pre_check :require_super_admins!

    def create?
      record.sync? &&
        record.added_merchants_count.positive? &&
        (record.nostr_event.nil? || nostr_step&.error?)
    end

    private

    def nostr_step
      record.merchant_sync_steps.publish_to_nostr.first
    end
  end
end
