class DirectoryFriend
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :link, :string
  attribute :icon, :string
  attribute :image, :string
  attribute :svg_image, :string

  validates :name, presence: true
  validates :link, presence: true

  def self.all
    data = YAML.load_file('db/yaml/directory_friends.yml')

    data.map do |row|
      model = new(row)
      next unless model.valid?

      DirectoryFriendDecorator.new(model)
    end
  end
end
