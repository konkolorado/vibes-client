require 'thor'
require 'vibes_client'

class WalletCampaign < Thor
  desc 'campaigns COMPANY_KEY', 'Display wallet campaigns for a company'
  def campaigns(company_key)
    username = VibesClientSettings.username
    password = VibesClientSettings.password
    log_level = options[:verbose] ? :debug : :warn

    wc = WalletCampaignClient.new(username: username, password: password, company_key: company_key,
                                  log_level: log_level)
    wallet_campaigns = wc.list_campaigns
    puts JSON.pretty_generate(wallet_campaigns.body)
  end

  desc 'campaign COMPANY_KEY CAMPAIGN_ID', "Display a company's wallet campaign"
  def campaign(company_key, campaign_id)
    log_level = options[:verbose] ? :debug : :warn
    wc = WalletCampaignClient.new(company_key: company_key, log_level: log_level)
    campaign = wc.get_wallet_campaign_by_id(campaign_id)
    puts JSON.pretty_generate(campaign.body)
  end

  desc 'items COMPANY_KEY CAMPAIGN_ID', "Display items in company's wallet campaign"
  def items(company_key, campaign_id)
    log_level = options[:verbose] ? :debug : :warn
    wc = WalletCampaignClient.new(company_key: company_key, log_level: log_level)
    items = wc.get_wallet_campaign_items(campaign_id)
    puts JSON.pretty_generate(items.body)
  end

  desc 'item COMPANY_KEY CAMPAIGN_ID ITEM_ID', "Display an item in company's wallet campaign"
  def item(company_key, campaign_id, item_id)
    log_level = options[:verbose] ? :debug : :warn
    wc = WalletCampaignClient.new(company_key: company_key, log_level: log_level)
    item = wc.get_wallet_campaign_item_by_id(campaign_id, item_id)
    puts JSON.pretty_generate(item.body)
  end

  desc 'item_put COMPANY_KEY CAMPAIGN_ID ITEM_ID', "Display an item in company's wallet campaign"
  def item_put(company_key, campaign_id, item_id)
    log_level = options[:verbose] ? :debug : :warn
    wc = WalletCampaignClient.new(company_key: company_key, log_level: log_level)
    item = wc.update_wallet_campaign_item_by_id(
      campaign_id,
      item_id,
      { "tokens": { "expiration_date": '2017-02-18T19:30Z' } }
    )
    puts JSON.pretty_generate(item.body)
  end
end
