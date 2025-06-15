class CryptoAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if CryptoPatterns.detect_type(value)

    record.errors.add(attribute, options[:message] || 'is not a valid crypto address')
  end
end
