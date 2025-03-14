require 'thor'
require 'vibes_client'

class Subscription < Thor
  desc 'for-person ID', 'Retrieve a subscription for a person by their person key'
  def for_person(company_key, person_key)
    username = VibesClientSettings.username
    password = VibesClientSettings.password
    log_level = options[:verbose] ? :debug : :warn
    sc = SubscriptionClient.new(username: username, password: password, company_key: company_key,
                                log_level: log_level)
    subscription = sc.get_subscription_by_person_key(person_key)
    puts JSON.pretty_generate(subscription.body)
  end
end
