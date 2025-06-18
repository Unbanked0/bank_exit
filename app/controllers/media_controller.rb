class MediaController < ApplicationController
  # @route GET /fr/media {locale: "fr"} (media_fr)
  # @route GET /es/media {locale: "es"} (media_es)
  # @route GET /en/media {locale: "en"} (media_en)
  # @route GET /media
  def index
    @interviews = Media::Interview.all
    @newspapers = Media::Newspaper.all
  end
end
