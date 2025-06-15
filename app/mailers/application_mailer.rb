class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@bank-exit.org',
          to: 'sortiedebanque@tutamail.com'

  layout 'mailer'
end
