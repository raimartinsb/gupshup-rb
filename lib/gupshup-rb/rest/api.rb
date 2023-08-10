module Gupshup
  module REST
    class Api < Domain
      ##
      # Initialize the Api Domain
      def initialize(gupshup)
        super

        #@base_url = 'https://api.gupshup.com'
        #@host = 'api.gupshup.com'
        #@port = 443
        @uri = "https://api.gupshup.io/sm/api/v1/msg"

        # Versions
        @v1 = nil
      end

      ##
      # Version v1 of api
      def v1
        @v1 ||= V1.new self
      end
      
      ##
      # @param [String] sid The unique string that that we created to identify the
      #   Message resource.
      # @return [Gupshup::REST::Api::V1::AccountContext::MessageInstance] if sid was passed.
      # @return [Gupshup::REST::Api::V1::AccountContext::MessageList]
      def messages(sid=:unset)
        self.messages(sid)
      end

      ##
      # Provide a user friendly representation
      def to_s
        '#<Gupshup::REST::Api>'
      end
    end
  end
end