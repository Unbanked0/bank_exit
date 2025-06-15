class MerchantReportIssue < ApplicationService
  include Rails.application.routes.url_helpers

  attr_reader :merchant, :merchant_report

  def initialize(merchant, merchant_report)
    @merchant = merchant
    @merchant_report = merchant_report
  end

  def call
    GithubAPI.new.create_issue!(
      title: title,
      body: body,
      labels: labels
    )
  end

  private

  def title
    "Anomaly on merchant: `#{merchant.name}`"
  end

  def description
    merchant_report.description.split("\n").map do |line|
      "> #{line}"
    end.join("\n")
  end

  def body
    <<~MARKDOWN
      An anomaly has been identified on the **#{merchant.name}** merchant. Please take a look and update on OpenStreetMap accordingly:

      #{description}

      ---

      - Merchant on Bank-Exit: #{merchant_url(@merchant)}
      - Merchant on OpenStreetMap: #{@merchant.osm_link}

      *Note: this issue has been automatically opened from bank-exit website using the Github API.*
    MARKDOWN
  end

  def labels
    [
      'merchant',
      'anomaly',
      I18n.t(I18n.locale, scope: 'languages', locale: :en)
    ]
  end
end
