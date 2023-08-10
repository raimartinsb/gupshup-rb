require 'uuid'
RSpec.describe Gupshup do
  before do
    @api_key = ''
    @destination = ''
    @phone = 'numberGupshup'
    @src_name = ''
    @version  = '2'
  end
  it 'version number' do
    expect(Gupshup::VERSION).not_to be nil
  end

  it 'Send text' do
    to = @destination
    from = @phone 
    body = 'Hello world'
    payload = {
      :type => "text",
      :text => 'Hello world'
    }
    message = Gupshup::REST::API::V1::MessageList.new(@version, @src_name)
    req = message.create(to, from, body, @src_name , @api_key)

    expect(req.status_code).to be 202
  end
end
