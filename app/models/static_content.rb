class StaticContent
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Findable

  attr_accessor :model

  def self.human_count(count, pretty_count:)
    "<strong>#{pretty_count}</strong> #{model_name.human(count: count)}"
  end

  def initialize(model)
    super
    @model = model.with_indifferent_access
  end

  def to_param
    identifier
  end

  def persisted?
    true
  end

  def render_template
    @render_template ||= ApplicationController.renderer.render(
      template: template,
      formats: [:html],
      layout: false,
      assigns: {
        record: self
      }
    )

    @render_template
  end

  private

  def template
    @template ||= "#{self.class.model_name.plural}/#{identifier.underscore}/show"
  end
end
