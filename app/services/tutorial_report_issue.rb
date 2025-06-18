class TutorialReportIssue < ApplicationService
  include Rails.application.routes.url_helpers

  attr_reader :tutorial, :tutorial_report

  def initialize(tutorial, tutorial_report)
    @tutorial = tutorial
    @tutorial_report = tutorial_report
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
    tutorial_report.title
  end

  def description
    tutorial_report.description.split("\n").map do |line|
      "> #{line}"
    end.join("\n")
  end

  def body
    <<~MARKDOWN
      An anomaly has been identified on the **#{tutorial.title}** tutorial. Please take a look and fix content accordingly:

      #{description}

      ---

      - Tutorial: #{tutorial_en_url(tutorial.identifier)}

      *Note: this issue has been automatically opened from bank-exit website using the Github API.*
    MARKDOWN
  end

  def labels
    [
      'tutorial',
      'anomaly',
      I18n.t(I18n.locale, scope: 'languages', locale: :en)
    ]
  end
end
