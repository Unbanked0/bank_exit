# This class acts as a model (not related to the database)
# to interact more elegantly with the {Interview interviews},
# and {Newspaper newspapers} resources.
class Media
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :url, :string
  attribute :title, :string
  attribute :created_at, :date

  def self.all
    model_kind = name.underscore.pluralize
    data = YAML.load_file("db/yaml/#{model_kind}.yml")

    data.map { |row| new(row) }
  end
end
