class ContactWayDecorator < ApplicationDecorator
  def clean_url
    value.delete_prefix('https://')
         .delete_prefix('http://')
         .delete_prefix('www.')
         .delete_suffix('/')
  end
end
