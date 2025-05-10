# typed: true

require "thor"
require "json"

require_relative "../vibes_client/acquisition_campaign_client"
require_relative "../vibes_client/errors"

class AcquisitionCampaign < Thor
  desc "campaigns COMPANY_KEY", "Display acquisition campaigns for a company"
  def campaigns(company_key)
    wc = AcquisitionCampaignClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.campaigns
    puts JSON.pretty_generate(response.body)
  end

  desc "campaign COMPANY_KEY CAMPAIGN_ID", "Display an acquisition campaign"
  def campaign(company_key, campaign_id)
    wc = AcquisitionCampaignClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    response = wc.campaign(campaign_id)
    puts JSON.pretty_generate(response.body)
  end

  desc "pending-participants COMPANY_KEY CAMPAIGN_ID", "Display an acquisition campaign's pending participants"
  option :mdn, desc: "Search by mdn"
  option :person_id, desc: "Search by person id"
  option :external_person_id, desc: "Search by external person id"
  def pending_participants(company_key, campaign_id)
    if options[:mdn].nil? && options[:person_id].nil? && options[:external_person_id].nil?
      raise Thor::Error, "At least one search option (--mdn, --person-id, or --external-person-id) must be provided"
    end

    wc = AcquisitionCampaignClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    opts = {
      mdn: options[:mdn],
      person_id: options[:person_id],
      external_person_id: options[:external_person_id]
    }
    response = wc.pending_participants(campaign_id, **opts)
    puts JSON.pretty_generate(response.body)
  end

  desc "add-participant COMPANY_KEY CAMPAIGN_ID", "Add a participant to an acquisition campaign"
  option :mdn, desc: "Add with mdn"
  option :person_id, desc: "Add with person id"
  option :external_person_id, desc: "Add with external person id"
  option :custom_fields, desc: "Add with custom fields"
  def add_participant(company_key, campaign_id)
    if options[:mdn].nil? && options[:person_id].nil? && options[:external_person_id].nil?
      raise Thor::Error, "At least one search option (--mdn, --person-id, or --external-person-id) must be provided"
    end

    wc = AcquisitionCampaignClient.new(
      company_key: company_key,
      log_level: options[:verbose] ? :debug : :warn
    )
    opts = {
      mdn: options[:mdn] || "",
      person_id: options[:person_id] || "",
      external_person_id: options[:external_person_id] || ""
    }
    custom_fields = options[:custom_fields] ? JSON.parse(options[:custom_fields]) : {}
    begin
      response = wc.add_participant(campaign_id, **opts, custom_fields: custom_fields)
    rescue VibesAPI::ConflictError, VibesAPI::UnprocessableEntityError => e
      puts "Error: #{e.response[:body]}"
    else
      puts JSON.pretty_generate(response.body)
    end
  end
end
