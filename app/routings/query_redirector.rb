class QueryRedirector
  def initialize(destination)
    @destination = destination
  end

  def call(_params, request)
    uri = URI.parse(request.original_url)
    if uri.query
      "#{@destination}?#{uri.query}"
    else
      @destination
    end
  end
end
