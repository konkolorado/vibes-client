# frozen_string_literal: true

require 'thor'
require 'vibes_client'
require_relative 'subcommand'

class Register < SubCommandBase
  desc 'subscription-added COMPANY_KEY LIST_ID URL', 'Register a subscription added callback'
  def subscription_added(company_key, list_id, url)
    log_level = options[:verbose] ? :debug : :warn
    cc = CallbacksClient.new(company_key: company_key, log_level: log_level)
    callbacks = cc.register_subscription_added_callback(list_id: list_id, url: url)
    puts JSON.pretty_generate(callbacks.body)
  end

  desc 'subscription-removed COMPANY_KEY LIST_ID URL', 'Register a subscription added callback'
  def subscription_removed(company_key, list_id, url)
    log_level = options[:verbose] ? :debug : :warn
    cc = CallbacksClient.new(company_key: company_key, log_level: log_level)
    callbacks = cc.register_subscription_removed_callback(list_id: list_id, url: url)
    puts JSON.pretty_generate(callbacks.body)
  end
end

class Callback < Thor
  desc 'list COMPANY_KEY', "Display a company's registered callbacks"
  def list(company_key)
    log_level = options[:verbose] ? :debug : :warn
    cc = CallbacksClient.new(company_key: company_key, log_level: log_level)
    callbacks = cc.list
    puts JSON.pretty_generate(callbacks.body)
  end

  desc 'cancel COMPANY_KEY CALLBACK_ID', 'Cancel a callback'
  def cancel(company_key, callback_id)
    log_level = options[:verbose] ? :debug : :warn
    cc = CallbacksClient.new(company_key: company_key, log_level: log_level)
    callbacks = cc.cancel(callback_id)
    puts JSON.pretty_generate(callbacks.body)
  end

  desc 'register', 'Register callbacks for a company'
  subcommand 'register', Register
end
