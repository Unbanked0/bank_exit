class ContactsController < ApplicationController
  ALLOWED_CONTACTS = %w[Session Nostr Email].freeze

  # @route GET /fr/contacts/:id {locale: "fr"} (contact_fr)
  # @route GET /es/contactos/:id {locale: "es"} (contact_es)
  # @route GET /en/contacts/:id {locale: "en"} (contact_en)
  # @route GET /contacts/:id
  def show
    unless params[:id].in?(ALLOWED_CONTACTS)
      head :not_found
      return
    end

    @contact = @contacts.find { |c| c.title == params[:id] }
  end
end
