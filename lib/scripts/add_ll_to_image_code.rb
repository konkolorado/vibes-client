# typed: true

require "sorbet-runtime"

require_relative "../vibes_client/wallet_campaign_client"

extend T::Sig

# This function updates the IMAGE_CODE on wallet items in a given file to various values
# of supported badge combinations
sig do
  params(company_key: String, campaign_id: String, filename: String).void
end
def add_ll_to_image_code(company_key, campaign_id, filename)
  valid_codes = ["FB_FF_LL", "FB_FF_LL_SS", "FB_LL", "FB_LL_SS"]
  wc = WalletCampaignClient.new(company_key: company_key, log_level: :warn)

  File.foreach(filename) do |wallet_item_id|
    wallet_item_id.strip!
    image_code = valid_codes.sample
    payload = {"tokens" => {"IMAGE_CODE" => image_code}}
    begin
      wc.update_wallet_campaign_item_by_id(campaign_id, wallet_item_id, payload)
    rescue Faraday::Error => e
      puts "Unable to update the IMAGE_CODE for wallet item #{wallet_item_id}: #{e.message}"
    else
      puts "Updated wallet item #{wallet_item_id} to IMAGE_CODE: #{image_code}"
    end
  end
end
