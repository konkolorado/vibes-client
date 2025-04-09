require_relative 'client'

class CallbacksClient
  include VibesClientSettings

  def initialize(company_key:, log_level:)
    @client = Client.new(username: username, password: password, base_url: api_url).client(log_level: log_level)
    @company_key = company_key
  end

  def list_callbacks
    endpoint = "/companies/#{@company_key}/config/callbacks/"
    @client.get(endpoint)
  end
end
