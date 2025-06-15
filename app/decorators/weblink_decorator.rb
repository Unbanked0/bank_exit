class WeblinkDecorator < ApplicationDecorator
  def clean_url
    url.delete_prefix('https://')
       .delete_prefix('http://')
       .delete_suffix('/')
  end
end
