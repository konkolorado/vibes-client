# typed: true

require "thor"

require_relative "../vibes_client/subscription_client"

class Subscription < Thor
  desc "for-person COMPANY_KEY KEY", "Retrieve a subscription for a person by their person key"
  def for_person(company_key, key)
    sc = SubscriptionClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    subscription = sc.get_subscription_by_person_key(key)
    puts JSON.pretty_generate(subscription.body)
  end
end
