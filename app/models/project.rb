class Project < Article
  attribute :description, :string
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

  private

  def crypto_box?
    identifier == 'sticker'
  end
end
