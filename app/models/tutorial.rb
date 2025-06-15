# This class acts as a model (not related to the database)
# to interact more elegantly with {Tutorial tutorials} resources.
class Tutorial < Article
  LEVELS = %i[beginner intermediate expert].freeze

  attribute :author, :string
  attr_writer :level, :time

  def level
    LEVELS[model[:level]]
  end
end
