# frozen_string_literal: true

# This function clears wallets that have a notification header set but no body. These wallets
# are stuck in a state where the Vibes API is unable to send the wallet data to the Google
# Wallet API meaning that all updates to wallet tokens will fail. This method will update
# the notifications on those wallets by pushing a valid notification body.
# Note: The Platform team has since fixed this issue and wallet notification changes will no
# longer be accepted if the notification body is empty.
#
# @param company_key [String] The Vibes company key
# @param campaign_id [String] The wallet campaign id
# @param filename [String] A filename containing a list of wallet item ids that are stuck
def fix_stuck_wallets(company_key, campaign_id, filename)
  wc = WalletCampaignClient.new(company_key: company_key, log_level: :warn)

  notifications = {
    google_wallet: {
      messages: {
        header: "Update",
        body: "Craving Portillo's to get you through the week? We get it. Grab a bite & keep earning badges! 🍔"
      }
    }
  }

  File.foreach(filename).with_index do |line, line_num|
    line = line.strip

    begin
      wallet = wc.get_wallet_campaign_item_by_id(campaign_id, line)
    rescue Faraday::Error => e
      puts "Skipping wallet that can't be pulled: #{line}: #{e.message}"
      next
    end
    unless ["", " ", nil, "null"].include?(wallet.body["google_wallet"]["messages"][0]["body"])
      puts "Skipping wallet with valid notification body: #{line}"
      next
    end

    print "Updating wallet ##{line_num}: #{line} --- "
    begin
      wc.update_wallet_campaign_item_by_id(
        campaign_id,
        line,
        notifications
      )
    rescue Faraday::Error => e
      p e.message
    else
      p "Ok"
    ensure
      sleep(1)
    end
  end
end
