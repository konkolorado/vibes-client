# typed: true

require "faraday"
require "faraday/request"

require_relative "settings"

class HttpClient
  extend T::Sig

  sig { params(username: String, password: String, base_url: String).void }
  def initialize(username:, password:, base_url:)
    @username = username
    @password = password
    @base_url = base_url
  end

  sig { params(log_level: Symbol).returns(Faraday::Connection) }
  def client(log_level: :debug)
    Faraday.new(url: @base_url) do |builder|
      builder.request :authorization, :basic, @username, @password
      # Sets the Content-Type header to application/json on each request.
      # Also, if the request body is a Hash, it will automatically be encoded as JSON.
      builder.request :json

      # Parses JSON response bodies.
      # If the response body is not valid JSON, it will raise a Faraday::ParsingError.
      builder.response :json

      # Raises an error on 4xx and 5xx responses.
      builder.response :raise_error

      # Logs requests and responses.
      # By default, it only logs the request method and URL, and the request/response headers.
      builder.response :logger, Logger.new($stderr) if log_level == :debug
    end
  end
end

class BaseVibesApiClient
  extend T::Sig
  include VibesClientSettings

  sig { params(company_key: String, log_level: Symbol).void }
  def initialize(company_key:, log_level:)
    @client = HttpClient.new(
      username: username || "", password: password || "", base_url: api_url || ""
    ).client(log_level: log_level)
    @company_key = company_key
  end
end
