# This class acts as a model (not related to the database)
# to interact more elegantly with the contact ways.
class Contact
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :icon, :string
  attribute :public_key, :string
  attribute :sticker, :string
  attribute :pgp_key, :string
  attribute :pgp_key_fingerprint, :string

  attr_reader :contact
  attr_accessor :links

  def self.all
    data = YAML.load_file('db/yaml/contacts.yml')

    data.map { |row| new(row).decorate }
  end

  def decorate
    ContactDecorator.new(self)
  end
end
