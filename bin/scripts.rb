# frozen_string_literal: true

require 'thor'
require 'vibes_client'

class Scripts < Thor
  desc 'clear-stuck-wallets COMPANY_KEY CAMPAIGN_ID FILE_NAME',
       'Reset notification data on a file containing a list of wallet item ids'
  def clear_stuck_wallets(company_key, campaign_id, filename)
    fix_stuck_wallets(company_key, campaign_id, filename)
  end

  desc 'set-ll-badge COMPANY_KEY CAMPAIGN_ID FILE_NAME',
       'Set IMAGE_CODE to contain the Local Legend badge on all wallet items in a file'
  def set_ll_badge(company_key, campaign_id, filename)
    add_ll_to_image_code(company_key, campaign_id, filename)
  end
end
