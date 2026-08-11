class Project < Article
  attribute :image, :string

  def banner
    super || 'banner-projects'
  end

  def cover?
    Rails.root.join("app/assets/images/#{cover}").exist?
  end

  def cover
    return "projects/#{identifier}/cover.png" if crypto_box?

    "projects/#{identifier}/cover.jpg"
  end

  def logo?
    cover?
  end

  def logo
    cover
  end

  private

  def crypto_box?
    identifier == 'sticker'
  end
end
