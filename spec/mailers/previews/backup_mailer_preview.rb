class BackupMailerPreview < ActionMailer::Preview
  delegate :send_geojson, to: :BackupMailer
end
