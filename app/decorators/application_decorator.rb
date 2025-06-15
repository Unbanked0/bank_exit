class ApplicationDecorator < SimpleDelegator
  def self.wrap(collection)
    collection.map do |model|
      new(model)
    end
  end

  def object
    __getobj__
  end

  def updated?
    created_at.strftime('%Y-%m-%d %H:%M:%s') != updated_at.strftime('%Y-%m-%d %H:%M:%s')
  end
end
