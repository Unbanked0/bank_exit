# Enqueue a job for a {Mixin::Callable service}.
#
# To enqueue a {Mixin::Callable service}, just call {Mixin::Callable.call_later #call_later} on it.
# You can also manually enqueue a job by giving the class name of the service
# as the first argument and its own parameters after.
#
# @example For a {Mixin::Callable service}
#   class MyService
#     include Mixin::Callable
#
#     def initialize(param_1, param_2)
#       # do stuff
#     end
#
#     def call
#       # do stuff
#     end
#   end
#
#   MyService.call_later('foo', 'bar')
#
# @example Manually
#   CallableJob.perform_later('MyService', 'foo', 'bar')
class CallableJob < ApplicationJob
  queue_as :default

  # @param callable_name [String] the service class name
  # @param * [Array<Object>] any service's parameters
  def perform(callable_name, *)
    callable_name.constantize.call(*)
  end
end
