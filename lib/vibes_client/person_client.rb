require_relative 'client'

class PersonClient
  def initialize(username:, password:, company_key:, log_level:, base_url: 'https://public-api.vibescm.com')
    @client = Client.new(username: username, password: password, base_url: base_url).client(log_level: log_level)
    @company_key = company_key
  end

  def find_by_mdn(mdn)
    params = { mdn: mdn }
    endpoint = "/companies/#{@company_key}/mobiledb/persons"
    @client.get(endpoint, params)
  end

  def get_by_person_key(key)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}"
    @client.get(endpoint)
  end
end
