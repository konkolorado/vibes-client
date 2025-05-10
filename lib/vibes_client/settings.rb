# typed: true

module VibesClientSettings
  extend T::Sig

  sig { returns(T.nilable(String)) }
  def username
    ENV["VIBES_USERNAME"]
  end

  sig { returns(T.nilable(String)) }
  def password
    ENV["VIBES_PASSWORD"]
  end

  sig { returns(T.nilable(String)) }
  def company_key
    ENV["VIBES_COMPANY_KEY"]
  end

  sig { returns(T.nilable(String)) }
  def api_url
    ENV["VIBES_API_URL"]
  end
end
