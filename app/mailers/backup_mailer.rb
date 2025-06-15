class BackupMailer < ApplicationMailer
  def send_geojson
    return unless json? && geojson? && timestamp?

    ['export.json', 'export.geojson'].each do |file|
      attachments[file] = File.read("#{files_folder_prefix}/#{file}")
    end

    @file_date = File.read("#{files_folder_prefix}/last_fetch_at.txt")
    @time = Time.zone.at(@file_date.to_i)

    mail
  end

  private

  def files_folder_prefix
    Rails.env.test? ? 'spec/fixtures/files' : 'storage'
  end

  def json?
    File.exist?("#{files_folder_prefix}/export.json")
  end

  def geojson?
    File.exist?("#{files_folder_prefix}/export.geojson")
  end

  def timestamp?
    File.exist?("#{files_folder_prefix}/last_fetch_at.txt")
  end
end
