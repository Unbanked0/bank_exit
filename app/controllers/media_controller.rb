class MediaController < ApplicationController
  # @route GET /fr/medias {locale: "fr"} (media_fr)
  # @route GET /es/medios {locale: "es"} (media_es)
  # @route GET /en/media {locale: "en"} (media_en)
  # @route GET /media
  def index
    @interviews = Media::Interview.all
    @newspapers = Media::Newspaper.all
  end
end
