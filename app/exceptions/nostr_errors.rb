class NostrErrors < BaseErrors
  MissingPrivateKey = Class.new(self)
  MissingRelayUrl = Class.new(self)

  PublicationError = Class.new(self) do
    def initialize(custom_message)
      super()

      @custom_message = custom_message
    end

    def message
      "#{super} - #{@custom_message}"
    end
  end
end
