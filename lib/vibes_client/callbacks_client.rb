# frozen_string_literal: true

require_relative "client"

class CallbacksClient
  include VibesClientSettings

  def initialize(company_key:, log_level:)
    @client = Client.new(username: username, password: password, base_url: api_url).client(log_level: log_level)
    @company_key = company_key
  end

  def list
    endpoint = "/companies/#{@company_key}/config/callbacks/"
    @client.get(endpoint)
  end

  def cancel(callback_id)
    endpoint = "/companies/#{@company_key}/config/callbacks/#{callback_id}"
    @client.delete(endpoint)
  end

  def register(body)
    endpoint = "/companies/#{@company_key}/config/callbacks/"
    @client.post(endpoint, body)
  end

  def register_subscription_added_callback(list_id:, url:, start_date: nil, end_date: nil)
    body = SubscriptionAddedCallbackBody.new(destination: DestinationBody.new(url: url),
      list_id: list_id,
      start_date: start_date,
      end_date: end_date).to_h

    register(body)
  end

  def register_subscription_removed_callback(list_id:, url:, start_date: nil, end_date: nil)
    body = SubscriptionRemovedCallbackBody.new(destination: DestinationBody.new(url: url),
      list_id: list_id,
      start_date: start_date,
      end_date: end_date).to_h

    register(body)
  end

  def register_wallet_installed_callback(wallet_id:, url:, start_date: nil, end_date: nil)
    body = WalletAddedCallbackBody.new(destination: DestinationBody.new(url: url),
      wallet_id: wallet_id,
      start_date: start_date,
      end_date: end_date).to_h

    register(body)
  end

  def register_wallet_removed_callback(wallet_id:, url:, start_date: nil, end_date: nil)
    body = WalletRemovedCallbackBody.new(destination: DestinationBody.new(url: url),
      wallet_id: wallet_id,
      start_date: start_date,
      end_date: end_date).to_h

    register(body)
  end
end

class DestinationBody
  def initialize(url:, method: "POST", content_type: "application/json")
    @url = url
    @method = method
    @content_type = content_type
  end

  def to_h
    {
      url: @url,
      method: @method,
      content_type: @content_type
    }
  end
end

class SubscriptionCallbackBody
  def initialize(destination:, list_id:, start_date: nil, end_date: nil)
    @destination = destination
    @list_id = list_id
    @start_date = start_date
    @end_date = end_date
  end

  def to_h
    result = {
      :callback_type => @callback_type,
      :destination => @destination.to_h,
      @callback_type => {
        list_id: @list_id
      }
    }
    result[:start_date] = @start_date if @start_date
    result[:end_date] = @end_date if @end_date
    result
  end
end

class SubscriptionAddedCallbackBody < SubscriptionCallbackBody
  def initialize(*args, **kwargs)
    @callback_type = "subscription_added"
    super
  end
end

class SubscriptionRemovedCallbackBody < SubscriptionCallbackBody
  def initialize(*args, **kwargs)
    @callback_type = "subscription_removed"
    super
  end
end

class WalletCallbackBody
  def initialize(destination:, wallet_id:, start_date: nil, end_date: nil)
    @destination = destination
    @wallet_id = wallet_id
    @start_date = start_date
    @end_date = end_date
  end

  def to_h
    result = {
      :callback_type => @callback_type,
      :destination => @destination.to_h,
      @callback_type => {
        campaign_token: @wallet_id
      }
    }
    result[:start_date] = @start_date if @start_date
    result[:end_date] = @end_date if @end_date
    result
  end
end

class WalletAddedCallbackBody < WalletCallbackBody
  def initialize(*args, **kwargs)
    @callback_type = "wallet_item_install"
    super
  end
end

class WalletRemovedCallbackBody < WalletCallbackBody
  def initialize(*args, **kwargs)
    @callback_type = "wallet_item_remove"
    super
  end
end
