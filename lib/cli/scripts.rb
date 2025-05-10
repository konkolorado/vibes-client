# typed: true

require "thor"

require_relative "../scripts/add_ll_to_image_code"

class Scripts < Thor
  desc "clear-stuck-wallets COMPANY_KEY CAMPAIGN_ID FILE_NAME",
    "Reset notification data on a file containing a list of wallet item ids"
  def clear_stuck_wallets(company_key, campaign_id, filename)
    fix_stuck_wallets(company_key, campaign_id, filename)
  end

  desc "set-ll-badge COMPANY_KEY CAMPAIGN_ID FILE_NAME",
    "Set IMAGE_CODE to contain the Local Legend badge on all wallet items in a file"
  def set_ll_badge(company_key, campaign_id, filename)
    add_ll_to_image_code(company_key, campaign_id, filename)
  end

  desc "update-wallet-location COMPANY_KEY CAMPAIGN_ID ITEM_ID",
    "Test explicitly setting wallet location via API"
  def update_wallet_location(company_key, campaign_id, item_id)
    test_updating_wallet_location(company_key, campaign_id, item_id)
  end
end
