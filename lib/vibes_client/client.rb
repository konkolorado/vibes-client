# frozen_string_literal: true

require 'faraday'
require 'faraday/request'

class Client
  def initialize(username:, password:, base_url:)
    @username = username
    @password = password
    @base_url = base_url
  end

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
