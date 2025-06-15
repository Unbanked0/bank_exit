# TODO: Delete me once SolidQueue add support for tasks.
# SolidQueue does not handle out of the box calling
# rake tasks. This placeholder jobs allows to patch
# it passing as argument the task to execute.
# @see https://github.com/rails/solid_queue/issues/379#issuecomment-2774496978
class RakeTaskJob < ApplicationJob
  queue_as :default

  def perform(task_name)
    Rails.application.load_tasks

    Rake::Task[task_name].invoke
  end
end
