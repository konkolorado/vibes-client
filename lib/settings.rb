class VibesClientSettings
  def self.username
    ENV['VIBES_USERNAME']
  end

  def self.password
    ENV['VIBES_PASSWORD']
  end

  def self.company_key
    ENV['VIBES_COMPANY_KEY']
  end
end
