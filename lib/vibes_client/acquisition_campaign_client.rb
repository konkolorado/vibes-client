# frozen_string_literal: true

require_relative 'client'

class AcquisitionCampaignClient
  include VibesClientSettings

  def initialize(company_key:)
    @client = Client.new(username: username, password: password, base_url: api_url).client
    @company_key = company_key
  end

  def add_participant(campaign_id, phone, custom_fields = {})
    endpoint = "/companies/#{@company_key}/campaigns/acquisition/#{campaign_id}/participants"
    payload = {
      mobile_phone: { "mdn": phone },
      "custom_fields": custom_fields
    }
    @client.post(endpoint, payload)
  end

  def list_campaigns
    endpoint = "/companies/#{@company_key}/campaigns/acquisition"
    @client.get(endpoint)
  end

  def get_campaign_by_id(campaign_id)
    endpoint = "/companies/#{@company_key}/campaigns/acquisition/#{campaign_id}"
    @client.get(endpoint)
  end
end
