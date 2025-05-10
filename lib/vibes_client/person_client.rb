# typed: true

require_relative "client"

class PersonClient < BaseVibesApiClient
  sig { params(mdn: String).returns(Faraday::Response) }
  def get_by_mdn(mdn)
    params = {mdn: mdn}
    endpoint = "/companies/#{@company_key}/mobiledb/persons"
    @client.get(endpoint, params)
  end

  sig { params(key: String).returns(Faraday::Response) }
  def get_by_person_key(key)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}"
    @client.get(endpoint)
  end

  sig { params(epid: String).returns(Faraday::Response) }
  def get_by_external_person_id(epid)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/external/#{epid}"
    @client.get(endpoint)
  end

  sig { params(key: String).returns(Faraday::Response) }
  def remove_external_person_id_by_person_key(key)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}"
    @client.put(endpoint, {external_person_id: nil})
  end

  # Add an external person id to a person record
  sig { params(key: String, external_person_id: String).returns(Faraday::Response) }
  def add_external_person_id_by_person_key(key, external_person_id)
    endpoint = "/companies/#{@company_key}/mobiledb/persons/#{key}"
    @client.put(endpoint, {external_person_id: external_person_id})
  end
end
