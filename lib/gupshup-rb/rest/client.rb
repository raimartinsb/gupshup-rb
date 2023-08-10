# frozen_string_literal: true

module Gupshup
  module REST
    ##
    # A client for accessing the Gupshup API.
    class Client
      @@default_region = 'us1'

      attr_accessor :http_client, :username, :password, :src_name, :api_key, :region, :edge, :logger, :user_agent_extensions

      ##
      # Initializes the Gupshup Client
      def initialize(username=nil, password=nil, src_name=nil, region=nil, http_client=nil, logger=nil, user_agent_extensions=nil)
        @src_name = src_name || Gupshup.src_name
        @api_key = password || Gupshup.api_key
        @auth = [@src_name, @api_key]
        @http_client = http_client || Gupshup.http_client || Gupshup::HTTP::Client.new
        @logger = logger || Gupshup.logger
        @user_agent_extensions = user_agent_extensions || []

        # Domains
        @api = nil
        @content = nil
        @conversations = nil
        @events = nil
        @media = nil
        @messaging = nil
        @video = nil
      end

      ##
      # Makes a request to the Gupshup API using the configured http client
      # Authentication information is automatically added if none is provided
      def request(host, port, method, uri, params={}, data={}, headers={}, auth=nil, timeout=nil)
        auth ||= @auth

        ruby_config = RbConfig::CONFIG
        headers['User-Agent'] = "gupshup-rb/#{Gupshup::VERSION} (#{ruby_config["host_os"]} #{ruby_config["host_cpu"]}) Ruby/#{RUBY_VERSION}"
        headers['Accept-Charset'] = 'utf-8'

        user_agent_extensions.each { |extension| headers['User-Agent'] += " #{extension}" }

        if method == 'POST' && !headers['Content-Type']
          headers['Content-Type'] = 'application/x-www-form-urlencoded'
        end

        unless headers['Accept']
          headers['Accept'] = 'application/json'
        end

        uri = build_uri(uri)

        if @logger
          @logger.debug("--BEGIN Gupshup API Request--")
          @logger.debug("Request Method: <#{method}>")

          headers.each do |key, value|
            unless key.downcase == 'authorization'
              @logger.debug("#{key}:#{value}")
            end
          end

          url = URI(uri)
          @logger.debug("Host:#{url.host}")
          @logger.debug("Path:#{url.path}")
          @logger.debug("Query:#{url.query}")
          @logger.debug("Request Params:#{params}")
        end

        response = @http_client.request(
          host,
          port,
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )

        if @logger
          @logger.debug("Response Status Code:#{response.status_code}")
          @logger.debug("Response Headers:#{response.headers}")
          @logger.debug("--END Gupshup API REQUEST--")
        end

        response
      end

      ##
      # Build the final request uri
      def build_uri(uri)
        if @region.nil? and @edge.nil?
          return uri
        end

        parsed_url = URI(uri)
        pieces = parsed_url.host.split('.')
        product = pieces[0]
        domain = pieces[-2, 2]
        new_edge = @edge
        new_region = @region

        if pieces.length == 4
          new_region ||= pieces[1]
        elsif pieces.length == 5
          new_edge ||= pieces[1]
          new_region ||= pieces[2]
        end

        if !new_edge.nil? && new_region.nil?
          new_region = @@default_region
        end

        parsed_url.host = [product, new_edge, new_region, domain].select {|item| !item.nil?}.join('.')
        parsed_url.to_s
      end
      ##
      # Access the Api Gupshup Domain
      def api
        @api ||= Api.new self
      end
      ##
      # Access the Messaging Gupshup Domain
      # def messaging
      #  @messaging ||= Messaging.new self
      #end

      ##
      # @param [String] sid The unique string that that we created to identify the
      #   Message resource.
      # @return [Gupshup::REST::Api::V2010::AccountContext::MessageInstance] if sid was passed.
      # @return [Gupshup::REST::Api::V2010::AccountContext::MessageList]
      def messages(sid=:unset)
        puts "DEBUG: self.api = #{self.api.inspect}" # Verifique o valor de self.api
        self.api.v1.messages(sid)
      end
      ##
      # Provide a user friendly representation
      def to_s
        "#<Gupshup::REST::Client #{@src_name}>"
      end
    end
  end
end