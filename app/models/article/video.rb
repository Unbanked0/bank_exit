class Article
  class Video
    attr_reader :title, :url

    def initialize(title: nil, url: nil, created_at: nil)
      @title = title
      @url = url
      @created_at = created_at
    end

    def created_at
      Date.parse(@created_at)
    end

    def created_at?
      @created_at.present?
    end
  end
end
