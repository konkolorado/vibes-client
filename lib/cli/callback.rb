# typed: true

require "thor"
require_relative "../vibes_client/callbacks_client"
require_relative "subcommand"

class Register < SubCommandBase
  desc "subscription-added COMPANY_KEY LIST_ID URL", "Register a subscription added callback"
  def subscription_added(company_key, list_id, url)
    cc = CallbacksClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = cc.register_subscription_added_callback(list_id: list_id, url: url)
    puts JSON.pretty_generate(response.body)
  end

  desc "subscription-removed COMPANY_KEY LIST_ID URL", "Register a subscription added callback"
  def subscription_removed(company_key, list_id, url)
    cc = CallbacksClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = cc.register_subscription_removed_callback(list_id: list_id, url: url)
    puts JSON.pretty_generate(response.body)
  end
end

class Callback < Thor
  desc "list COMPANY_KEY", "Display a company's registered callbacks"
  def list(company_key)
    cc = CallbacksClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = cc.list
    puts JSON.pretty_generate(response.body)
  end

  desc "cancel COMPANY_KEY CALLBACK_ID", "Cancel a callback"
  def cancel(company_key, callback_id)
    cc = CallbacksClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = cc.cancel(callback_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "register", "Register callbacks for a company"
  subcommand "register", Register
end
