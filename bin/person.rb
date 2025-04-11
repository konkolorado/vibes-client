require 'thor'
require 'vibes_client'

class Person < Thor
  desc 'mdn COMPANY_KEY ID', 'Get a person record by their MDN'
  def mdn(company_key, mdn)
    log_level = options[:verbose] ? :debug : :warn
    pc = PersonClient.new(company_key: company_key, log_level: log_level)
    person = pc.get_by_mdn(mdn)
    puts JSON.pretty_generate(person.body)
  end

  desc 'epid COMPANY_KEY ID', 'Get a person record by their external person ID'
  def epid(company_key, mdn)
    log_level = options[:verbose] ? :debug : :warn
    pc = PersonClient.new(company_key: company_key, log_level: log_level)
    person = pc.get_by_mdn(mdn)
    puts JSON.pretty_generate(person.body)
  end

  desc 'pk COMPANY_KEY KEY', 'Get a person record by their person key'
  def pk(company_key, mdn)
    log_level = options[:verbose] ? :debug : :warn
    pc = PersonClient.new(company_key: company_key, log_level: log_level)
    person = pc.get_by_person_key(mdn)
    puts JSON.pretty_generate(person.body)
  end
end
