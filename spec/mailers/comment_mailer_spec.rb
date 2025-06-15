require 'rails_helper'

RSpec.describe CommentMailer do
  describe '#send_report_comment' do
    subject(:mail) do
      described_class
        .with(comment: comment, description: description)
        .send_report_comment
    end

    before { freeze_time }

    after do
      FileUtils.rm_rf(Rails.root.join('spec/fixtures/files/comment_mailer'))
    end

    let(:comment) { create :comment, flag_reason: :spam }
    let(:description) { 'Lorem ispum spam' }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq I18n.t('comment_mailer.send_report_comment.subject')
      expect(mail.to).to eq(['sortiedebanque@tutamail.com'])
      expect(mail.from).to eq(['no-reply@bank-exit.org'])
    end

    it 'renders the body', :aggregate_failures do
      expect(mail.body.encoded).to match(/Lorem ispum spam/)
      expect(mail.body.encoded).to match(/#{I18n.t('activerecord.attributes.comment.flag_reasons.spam')}/)
    end

    it 'creates a TXT file of the mail' do
      mail.subject

      filepath = Rails.root.join("spec/fixtures/files/comment_mailer/#{Time.current.to_fs(:number)}_send_report_comment.txt")

      expect(File).to exist(filepath)
    end
  end
end
