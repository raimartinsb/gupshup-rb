# frozen_string_literal: true

module Gupshup
  class GupshupResponse
    attr_accessor :status_code, :body

    # @deprecated Use 'Gupshup::Response' instead.
    def initialize(status_code, body)
      warn "'Gupshup::GupshupResponse' has been deprecated. Use 'Gupshup::Response' instead."
      response = Gupshup::Response.new(status_code, body)
      @status_code = response.status_code
      @body = response.body
    end

    def to_s
      "[#{@status_code}] #{@body}"
    end
  end
end
