# typed: true

require_relative "client"

class WalletCampaignClient < BaseVibesApiClient
  # Get all wallet campaigns for a company
  sig { returns(Faraday::Response) }
  def campaigns
    endpoint = "/companies/#{@company_key}/campaigns/wallet"
    @client.get(endpoint)
  end

  # Get a wallet campaign by id
  sig { params(id: String).returns(Faraday::Response) }
  def campaign(id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}"
    @client.get(endpoint)
  end

  # Get all items in a wallet campaign
  sig { params(id: String).returns(Faraday::Response) }
  def wallet_items(id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items"
    @client.get(endpoint)
  end

  # Get an item in a wallet campaign by its id
  sig { params(id: String, item_id: String).returns(Faraday::Response) }
  def wallet_item(id, item_id)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items/#{item_id}"
    @client.get(endpoint)
  end

  # Update an item in a wallet campaign
  sig { params(id: String, item_id: String, data: Hash).returns(Faraday::Response) }
  def update_wallet_campaign_item_by_id(id, item_id, data)
    endpoint = "/companies/#{@company_key}/campaigns/wallet/#{id}/items/#{item_id}"
    @client.put(endpoint, data)
  end
end
