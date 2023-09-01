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
    end
  end
end