# frozen_string_literal: true

module VibesClientSettings
  def username
    ENV['VIBES_USERNAME']
  end

  def password
    ENV['VIBES_PASSWORD']
  end

  def company_key
    ENV['VIBES_COMPANY_KEY']
  end

  def api_url
    ENV['VIBES_API_URL']
  end
end
