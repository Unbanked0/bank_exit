require 'rails_helper'

RSpec.describe BackupMailer do
  describe '#send_geojson' do
    subject(:mail) do
      described_class.send_geojson
    end

    context 'when json and geojson does not exist' do
      it 'does not send email', :aggregate_failures do
        expect(mail.subject).to be_nil
        expect(mail.to).to be_nil
        expect(mail.from).to be_nil
        expect(mail.attachments).to be_nil
        expect(mail.body).to be_empty
      end
    end

    context 'when json and geojson exists' do
      before do
        File.open('spec/fixtures/files/export.json', 'w')
        File.open('spec/fixtures/files/export.geojson', 'w')
        File.open('spec/fixtures/files/last_fetch_at.txt', 'w') do
          Time.current.to_i
        end
      end

      after do
        File.delete('spec/fixtures/files/export.json')
        File.delete('spec/fixtures/files/export.geojson')
        File.delete('spec/fixtures/files/last_fetch_at.txt')
      end

      it 'renders the headers', :aggregate_failures do
        expect(mail.subject).to eq I18n.t('backup_mailer.send_geojson.subject')
        expect(mail.to).to eq(['sortiedebanque@tutamail.com'])
        expect(mail.from).to eq(['no-reply@bank-exit.org'])
        expect(mail.attachments.map(&:filename)).to eq ['export.geojson', 'export.json']
      end

      it 'renders the body' do
        expect(mail.body.encoded).to match(/Voici le backup des fichiers JSON et GeoJSON/)
      end
    end
  end
end
