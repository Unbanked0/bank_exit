class Blog < Article
  def logo
    "blogs/#{identifier}/logo.png"
  end
end
