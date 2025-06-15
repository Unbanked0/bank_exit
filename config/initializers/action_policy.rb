# Monkey patch that make `action_policy` to play nicely with
# decorated models automatically without tweaking controllers
# and views each time.
module ActionPolicy
  module SimpleDelegator
    def policy_for(record:, **)
      record = record.__getobj__ while record.is_a?(Delegator)
      super
    end
  end
end
