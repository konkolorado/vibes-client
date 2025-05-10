# typed: true

require "sorbet-runtime"

require_relative "client"

class AcquisitionCampaignClient < BaseVibesApiClient
  extend T::Sig

  # Retrieve all campaigns for a company
  sig { returns(Faraday::Response) }
  def campaigns
    endpoint = "/companies/#{@company_key}/campaigns/acquisition"
    @client.get(endpoint)
  end

  # Retrieve a campaign by its id
  sig { params(campaign_id: String).returns(Faraday::Response) }
  def campaign(campaign_id)
    endpoint = "/companies/#{@company_key}/campaigns/acquisition/#{campaign_id}"
    @client.get(endpoint)
  end

  # Retrieve a campaign's pending participants. Supports filtering by one of mdn, person
  # id or external person id
  sig {
    params(
      campaign_id: String,
      mdn: T.nilable(String),
      person_id: T.nilable(String),
      external_person_id: T.nilable(String)
    ).returns(Faraday::Response)
  }
  def pending_participants(campaign_id, mdn: nil, person_id: nil, external_person_id: nil)
    params = {}
    if !mdn.nil?
      params[:mdn] = mdn
    elsif !person_id.nil?
      params[:person_id] = person_id
    elsif !external_person_id.nil?
      params[:external_person_id] = external_person_id
    else
      params = nil
    end

    endpoint = "/companies/#{@company_key}/campaigns/acquisition/#{campaign_id}/participants"
    @client.get(endpoint, params)
  end

  # Add a participant to a campaign. Fields set to nil will be removed from the person
  sig {
    params(
      campaign_id: String,
      mdn: String,
      person_id: String,
      external_person_id: String,
      custom_fields: T::Hash[String, String]
    ).returns(Faraday::Response)
  }
  def add_participant(
    campaign_id,
    mdn: "",
    person_id: "",
    external_person_id: "",
    custom_fields: {}
  )
    payload = {"custom_fields" => custom_fields}
    payload["person_id"] = person_id unless person_id.empty?
    payload["external_person_id"] = external_person_id unless external_person_id.empty?
    payload["mobile_phone"] = {"mdn" => mdn} unless mdn.empty?
    endpoint = "/companies/#{@company_key}/campaigns/acquisition/#{campaign_id}/participants"
    @client.post(endpoint, payload)
  end
end
