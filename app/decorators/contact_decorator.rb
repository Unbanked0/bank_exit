class ContactDecorator < ApplicationDecorator
  def main_link
    links.first
  end

  def secondary_link
    links.second
  end

  def session?
    title == 'Session'
  end

  def nostr?
    title == 'Nostr'
  end

  def email?
    title == 'Email'
  end

  def pgp_key?
    pgp_key.present?
  end

  def pgp_key_fingerprint?
    pgp_key? && pgp_key_fingerprint.present?
  end
end
