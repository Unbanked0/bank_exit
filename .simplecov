return unless ENV['COVERAGE']

SimpleCov.start :rails do
  formatter SimpleCov::Formatter::HTMLFormatter

  add_filter 'app/channels'
  add_filter 'app/jobs'
  add_filter 'app/controllers/concerns/http_auth_concern.rb'
  add_filter 'app/jobs/rake_task_job.rb'
  add_filter 'lib/tasks/annotate_rb.rake'

  add_group 'Services', 'app/services'
  add_group 'Decorators', 'app/decorators'
  add_group 'Presenters', 'app/presenters'
  add_group 'Policies', 'app/policies'
end
