
require 'faraday'

module Gupshup
  module HTTP
    class Client
      attr_accessor :adapter
      attr_reader :last_response, :last_request
      def initialize
        @adapter = Faraday.default_adapter
      end

      def _request(request)
        @connection = Faraday.new(url: "#{request.host}:#{request.port.to_s}", ssl: { verify: true }) do |f|
          f.request :url_encoded
          f.adapter @adapter
          f.headers = request.headers
        end
        @last_request = request
        @last_response = nil
        response = send(request)
        if response.status == 504
          object = { message: 'Request timeout', code: 504 }.to_json
        elsif response.body && !response.body.empty?
          object = response.body
        elsif response.status == 400
          object = { message: 'Bad request', code: 400 }.to_json
        end

        gupshup_response = Gupshup::Response.new(response.status, object, headers: response.headers)
        @last_response = gupshup_response

        gupshup_response
      end

      def send(request)
        @connection.send(request.method.downcase.to_sym,
                         request.url,
                         request.method == 'GET' ? request.params : request.data)
      rescue Faraday::Error => e
        raise Gupshup::REST::GupshupError, e
      end

      def request(host, port, method, url, data = {}, headers = {}, params = {}, auth = nil, timeout = nil)
        request = Gupshup::Request.new(host, port, method, url, params, data, headers)
        _request(request)

      end
    end
  end
end


