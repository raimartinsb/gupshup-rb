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
      def initialize(src_name=nil, api_key=nil)
        @src_name = src_name
        @api_key = api_key
        @auth = [@src_name, @api_key]
        #$@logger = logger || Gupshup.logger
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

      def messages(to=nil, from=nil, body=nil, api_key=nil, src_name=nil)
        message_list = Gupshup::REST::Api::V1::MessageList.new('v1', src_name: src_name)

        message_list.create(to: to, from: from, body: body, media_url: '', content_type: 'text', api_key: api_key, src_name: src_name)
      end
      ##
      # Provide a user friendly representation
      def to_s
        "#<Gupshup::REST::Client #{@src_name}>"
      end
    end
  end
end