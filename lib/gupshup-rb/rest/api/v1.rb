
module Gupshup
  module REST
    class Api
      class V1 < Version
        ##
        # Initialize the V1 version of Api
        def initialize(domain)
          super
          @version = 'v1'
          @solution = {}
        end

        def messages(sid=:unset)
          raise ArgumentError, 'sid cannot be nil' if sid.nil?

          @messages = V1::MessageList.new(@version, src_name: @solution[:sid], )

          @messages
        end
        ##
        # Provide a user friendly representation
        def to_s
          '<Gupshup::REST::Api::V1>'
        end
      end
    end
  end
end