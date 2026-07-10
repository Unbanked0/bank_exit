SimpleCov.load_profile 'rails'

SimpleCov.group 'Policies', 'app/policies'
SimpleCov.group 'Services', 'app/services'
SimpleCov.group 'Serializers', %w[app/serializers app/blueprints]
SimpleCov.group 'Decorators', 'app/decorators'
SimpleCov.group 'Presenters', 'app/presenters'

SimpleCov.skip 'app/controllers/concerns/http_auth_concern.rb'
SimpleCov.skip 'app/jobs/rake_task_job.rb'
SimpleCov.skip 'lib/tasks/annotate_rb.rake'
SimpleCov.skip 'app/channels'
