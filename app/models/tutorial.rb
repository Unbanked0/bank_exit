class Tutorial < Article
  attribute :coins, array: true, default: -> { [] }

  def logo
    "tutorials/#{identifier}/logo.png"
  end
end
