require "thor"
require "vibes_client"
require "json"

require_relative "acquisition_campaign"
require_relative "person"
require_relative "wallet_campaign"
require_relative "subscription"
require_relative "scripts"

class VBC < Thor
  def self.exit_on_failure? = true

  class_option :verbose, type: :boolean

  desc "acquistion SUBCOMMAND ...ARGS", "interact with an acquisition campaign"
  subcommand "acquistion", AcquisitionCampaign

  desc "person SUBCOMMAND ...ARGS", "interact with a person record"
  subcommand "person", Person

  desc "wallet SUBCOMMAND ...ARGS", "interact with a wallet campaign"
  subcommand "wallet", WalletCampaign

  desc "subscription SUBCOMMAND ...ARGS", "interact with subscriptions"
  subcommand "subscription", Subscription

  desc "scripts SUBCOMMAND ...ARGS", "run helper scripts"
  subcommand "scripts", Scripts

  # desc 'callback SUBCOMMAND ...ARGS', 'interact with callbacks'
  # subcommand 'callback', Callback
  #
end
