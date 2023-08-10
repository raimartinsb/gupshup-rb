# frozen_string_literal: true

module Gupshup
  module Util
    class Configuration
      attr_accessor :src_name, :api_key, :http_client, :region, :edge, :logger

      def src_name=(value)
        @src_name = value
      end

      def api_key=(value)
        @api_key = value
      end

      def http_client=(value)
        @http_client = value
      end

      def region=(value)
        @region = value
      end

      def edge=(value)
        @edge = value
      end

      def logger=(value)
        @logger = value
      end
    end
  end
end
