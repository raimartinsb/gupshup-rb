module Gupshup
  module REST
    class Api < Domain
      class V1 < Version
        class MessageList < ListResource
          ##
          # Initialize the MessageList
          # @param [Version] version Version that contains the resource
          # @param [String] src_name The SID 
          # @return [MessageList] MessageList
          # def initialize(version, src_name: nil, content_type, from, apikey)
          def initialize(version, src_name: nil)
            super(version)

            # Path Solution
            @solution = {src_name: src_name}
            @uri = "https://api.gupshup.io/sm/api/v1/msg"
            @base_url = 'https://api.gupshup.io'
            @path = '/sm/api/v1/msg'

            @channel = 'whatsapp'
        
          end
          def create(to: nil, from: :unset, body: :unset, media_url: :unset, content_type: :unset, src_name: :unset, api_key: :unset)
            headers = { 'apikey' => api_key}
            binding.local_variables.each do |var_name|
              var_value = binding.local_variable_get(var_name)
              puts "#{var_name}: #{var_value}"
            end

            #case message_params[:type]
            #when 'text'
            #else
              send_text_message(headers, from, to, body, src_name)
            #end
            #end


          end

          # @param [Object] destination
          def send_text_message(headers, from, to, body, src_name)
            payload = {'type' => 'text',
                      'text' => body }.to_json
            data = { 'channel' => @channel,
                    'destination' => to,
                    'source' => from,
                    'src.name' => src_name,
                    'message' => payload }
            r = Gupshup::HTTP::Client.new
            r.request(host = @base_url, port = 443, method = 'POST', url = @path, data = data, headers = headers)
            
          end

        end
      end
    end
  end
end