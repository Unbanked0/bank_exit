# Replace requests log such as
#   > Started GET "/" for 127.0.0.1 at 2012-03-10 14:28:14 +0100
# by
#   > Started GET "/" for [FILTERED] at 2012-03-10 14:28:14 +0100
Logstop.guard(Rails.logger, ip: true, mac: true)
