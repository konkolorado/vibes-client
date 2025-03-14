require_relative 'client'

class EventTriggeredCampaignClient
  include VibesClientSettings

  def initialize(company_key:)
    @client = Client.new(username: username, password: password, base_url: api_url).client
    @company_key = company_key
  end

  def create_campaign(name:, event_name:, start_date:, end_date:, message_template:)
    endpoint = "/companies/#{@company_key}/mobiledb/event_triggered_messages"
    @client.post(endpoint)
  end

  def trigger_event(event:, data:)
    endpoint = "companies/#{@company_key}/events"
    payload = { event_type: event, event_data: data }
    @client.post(endpoint, payload)
  end
end
