class ApplicationPolicy < ActionPolicy::Base
  authorize :user, optional: true
end
