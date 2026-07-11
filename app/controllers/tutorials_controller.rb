class TutorialsController < PublicController
  before_action :set_tutorial, only: :show
  before_action :set_coins, only: :show

  add_breadcrumb proc { I18n.t('application.header.home') }, :root_path
  add_breadcrumb proc { I18n.t('application.header.guides') }
  add_breadcrumb proc { I18n.t('application.header.tutorials') }, :tutorials_path

  # @route GET /fr/tutorials {locale: "fr"} (tutorials_fr)
  # @route GET /es/tutorials {locale: "es"} (tutorials_es)
  # @route GET /de/tutorials {locale: "de"} (tutorials_de)
  # @route GET /it/tutorials {locale: "it"} (tutorials_it)
  # @route GET /en/tutorials {locale: "en"} (tutorials_en)
  # @route GET /tutorials
  def index
    tutorials = Tutorial.all(decorate: true)

    @highlighted_tutorials, @other_tutorials =
      tutorials.partition(&:highlight?)
  end

  # @route GET /fr/tutorials/:id {locale: "fr"} (tutorial_fr)
  # @route GET /es/tutorials/:id {locale: "es"} (tutorial_es)
  # @route GET /de/tutorials/:id {locale: "de"} (tutorial_de)
  # @route GET /it/tutorials/:id {locale: "it"} (tutorial_it)
  # @route GET /en/tutorials/:id {locale: "en"} (tutorial_en)
  # @route GET /tutorials/:id
  def show
    add_breadcrumb @tutorial.title, tutorial_path(@tutorial)

    set_meta_tags title: @tutorial.title,
                  description: @tutorial.short_description
  end

  private

  def set_tutorial
    @tutorial = Tutorial.find(params.expect(:id), decorate: true)
  end

  def set_coins
    @coins = Coin.where(@tutorial.coins, decorate: true)
  end
end
