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
    "projects/#{identifier}/cover.jpg"
  end
end
