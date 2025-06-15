# This class acts as a model (not related to the database)
# to interact more elegantly with the {Newspaper newspaper} data.
class Media
  class Newspaper < Media
    attribute :brand, :string
  end
end
