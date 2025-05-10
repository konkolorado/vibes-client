# typed: true

require "thor"

require_relative "../vibes_client/person_client"

class Person < Thor
  desc "mdn COMPANY_KEY ID", "Get a person record by their MDN"
  def mdn(company_key, mdn)
    pc = PersonClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = pc.get_by_mdn(mdn)
    puts JSON.pretty_generate(response.body)
  end

  desc "epid COMPANY_KEY ID", "Get a person record by their external person ID"
  def epid(company_key, external_person_id)
    pc = PersonClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = pc.get_by_external_person_id(external_person_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "pk COMPANY_KEY KEY", "Get a person record by their person key"
  def pk(company_key, key)
    pc = PersonClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = pc.get_by_person_key(key)
    puts JSON.pretty_generate(response.body)
  end

  desc "clear-epid COMPANY_KEY PERSON_KEY", "Remove a person's external person id"
  def clear_epid(company_key, person_key)
    pc = PersonClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = pc.remove_external_person_id_by_person_key(person_key)
    puts JSON.pretty_generate(response.body)
  end

  desc "set-epid COMPANY_KEY PERSON_KEY EXTERNAL_PERSON_ID", "Set a person's external person id"
  def set_epid(company_key, person_key, external_person_id)
    pc = PersonClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = pc.add_external_person_id_by_person_key(person_key, external_person_id)
    puts JSON.pretty_generate(response.body)
  end
end
