# typed: true

require "thor"

require_relative "../vibes_client/wallet_campaign_client"

class WalletCampaign < Thor
  desc "campaigns COMPANY_KEY", "Display wallet campaigns for a company"
  def campaigns(company_key)
    wc = WalletCampaignClient.new(
      company_key: company_key, log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.campaigns
    puts JSON.pretty_generate(response.body)
  end

  desc "campaign COMPANY_KEY CAMPAIGN_ID", "Display a company's wallet campaign"
  def campaign(company_key, campaign_id)
    wc = WalletCampaignClient.new(
      company_key: company_key, log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.campaign(campaign_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "items COMPANY_KEY CAMPAIGN_ID", "Display items in company's wallet campaign"
  def items(company_key, campaign_id)
    wc = WalletCampaignClient.new(
      company_key: company_key, log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.wallet_items(campaign_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "item COMPANY_KEY CAMPAIGN_ID ITEM_ID", "Display an item in company's wallet campaign"
  def item(company_key, campaign_id, item_id)
    wc = WalletCampaignClient.new(
      company_key: company_key, log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.wallet_item(campaign_id, item_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "item_update COMPANY_KEY CAMPAIGN_ID ITEM_ID [key:value, ...]", "Set tokens on an item"
  def item_update(company_key, campaign_id, item_id, *tokens)
    tokens = tokens.each_with_object({}) do |pair, h|
      key, value = pair.split(":", 2)
      h[key] = value
    end

    wc = WalletCampaignClient.new(
      company_key: company_key, log_level: options[:verbose] ? :debug : :warn
    )
    item = wc.update_wallet_campaign_item_by_id(
      campaign_id, item_id, {tokens: tokens}
    )
    puts JSON.pretty_generate(item.body)
  end
end
