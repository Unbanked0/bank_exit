class Tutorial < Article
  LEVELS = %i[beginner intermediate expert].freeze

  attribute :author, :string
  attribute :coins, array: true, default: -> { [] }
  attr_writer :level, :time

  def level
    LEVELS[model[:level]]
  end

  def logo
    "tutorials/#{identifier}/logo.png"
  end
end
