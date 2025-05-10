# typed: true

require_relative "client"

class SubscriptionClient < BaseVibesApiClient
  sig { params(key: String).returns(Faraday::Response) }
  def get_subscription_by_person_key(key)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}/subscriptions"
    @client.get(endpoint)
  end

  sig { params(key: String, subscription_id: String).returns(Faraday::Response) }
  def unsubscribe_person_by_person_key(key, subscription_id)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}/subscriptions/#{subscription_id}"
    @client.delete(endpoint)
  end
end
