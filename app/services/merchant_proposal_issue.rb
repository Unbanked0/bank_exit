class MerchantProposalIssue < ApplicationService
  attr_reader :merchant_proposal

  def initialize(merchant_proposal)
    @merchant_proposal = merchant_proposal.decorate
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
    "Proposal for a new merchant: `#{merchant_proposal.name}`"
  end

  def body
    <<~MARKDOWN
      A new proposition for a merchant has been submitted. Please take a look and add it to OpenStreetMap if relevant:

      ```
      #{merchant_proposal.to_osm}
      ```

      > [!NOTE]
      > - Country: `#{merchant_proposal.pretty_country}`
      > - Latitude: `#{merchant_proposal.latitude.presence || '--'}`
      > - Longitude: `#{merchant_proposal.longitude.presence || '--'}`

      > [!WARNING]
      > Merchants added to OpenStreetMap must comply with OSM mapping rules and best practices:
      >
      > - https://wiki.openstreetmap.org/wiki/Key:shop
      > - https://wiki.openstreetmap.org/wiki/Good_practice
      > - https://gitea.btcmap.org/teambtcmap/btcmap-general/wiki/Tagging-Merchants
      >
      > Online-only businesses must **not** be added to OSM. A merchant must have a real, verifiable physical location.
      >
      > If the business operates exclusively online and does not have a verifiable physical location, it should instead be proposed for inclusion in the Bank-Exit directory.
      >
      > The submitted category should also be reviewed and refined, as overly generic categories reduce data quality and usability.

      ---

      *Note: this issue has been automatically opened from bank-exit website using the Github API.*
    MARKDOWN
  end

  def labels
    [
      'merchant',
      'proposal',
      I18n.t(I18n.locale, scope: 'languages', locale: :en)
    ]
  end
end
