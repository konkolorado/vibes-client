require 'thor'
require 'vibes_client'

class Person < Thor
  desc 'mdn ID', 'Display a person record'
  def mdn(company_key, mdn)
    log_level = options[:verbose] ? :debug : :warn
    pc = PersonClient.new(company_key: company_key, log_level: log_level)
    person = pc.find_by_mdn(mdn)
    puts JSON.pretty_generate(person.body)
  end
end
