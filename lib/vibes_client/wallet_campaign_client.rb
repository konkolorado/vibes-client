# frozen_string_literal: true

require_relative 'client'
require_relative '../settings'

class WalletCampaignClient
  include VibesClientSettings

  def initialize(company_key:, log_level:)
    @client = Client.new(username: username, password: password, base_url: api_url).client(log_level: log_level)
    @company_key = company_key
  end

  def list_campaigns
    endpoint = "companies/#{@company_key}/campaigns/wallet"
    @client.get(endpoint)
  end

  def get_wallet_campaign_by_id(id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}"
    @client.get(endpoint)
  end

  def get_wallet_campaign_items(id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items"
    @client.get(endpoint)
  end

  def get_wallet_campaign_item_by_id(id, item_id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items/#{item_id}"
    @client.get(endpoint)
  end

  def update_wallet_campaign_item_by_id(id, item_id, data)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items/#{item_id}"
    @client.put(endpoint, data)
  end
end
