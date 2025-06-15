# This concern provide sugar to deal with deletable models.
module Deletable
  extend ActiveSupport::Concern

  included do
    scope :deleted, -> { where.not(deleted_at: nil) }
    scope :available, -> { where(deleted_at: nil) }
  end

  # Mark the object as deleted.
  #
  # @param at [Time] the time where deleted
  def soft_delete!(at: Time.current)
    update_attribute(:deleted_at, at)
  end

  # Mark the object as available
  #
  # @return [Boolean]
  def undelete!
    update_attribute(:deleted_at, nil)
  end

  # Return true if the object is available.
  #
  # @return [Boolean]
  def available?
    deleted_at.nil?
  end

  # Return true if the object is deleted.
  #
  # @return [Boolean]
  def deleted?
    !available?
  end
end
