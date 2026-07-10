class Blog < Article
  def cover?
    Rails.root.join("app/assets/images/banners/#{banner}.jpg").exist?
  end

  def cover
    "banners/#{banner}.jpg"
  end
end
