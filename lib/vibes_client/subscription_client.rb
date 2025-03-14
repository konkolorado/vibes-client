require_relative 'client'

class SubscriptionClient
  def initialize(username:, password:, company_key:, log_level:, base_url: 'https://public-api.vibescm.com')
    @client = Client.new(username: username, password: password, base_url: base_url).client(log_level: log_level)
    @company_key = company_key
  end

  def get_subscription_by_person_key(key)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}/subscriptions"
    @client.get(endpoint)
  end

  def unsubscribe_person_by_person_key(person_key, subscription_id)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{person_key}/subscriptions/#{subscription_id}"
    @client.delete(endpoint)
  end
end
