require 'thor'
require 'vibes_client'

class Callback < Thor
  desc 'list COMPANY_KEY', "Display a company's registered callbacks"
  def list(company_key)
    log_level = options[:verbose] ? :debug : :warn
    cc = CallbacksClient.new(company_key: company_key, log_level: log_level)
    callbacks = cc.list_callbacks
    puts JSON.pretty_generate(callbacks.body)
  end
end
