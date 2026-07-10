# This class acts as a model (not related to the database)
# to interact more elegantly with {Tutorial tutorials} resources.
class Tutorial < Article
  LEVELS = %i[beginner intermediate expert].freeze

  attribute :author, :string
  attr_writer :level, :time

  def level
    LEVELS[model[:level]]
  end

  def cover?
    Rails.root.join("app/assets/images/tutorials/#{identifier}/logo.png").exist?
  end

  def cover
    "tutorials/#{identifier}/logo.png"
  end
end
