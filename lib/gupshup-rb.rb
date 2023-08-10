# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'cgi'
require 'openssl'
require 'base64'
require 'forwardable'
require 'time'
require 'json'

require 'gupshup-rb/version' unless defined?(Gupshup::VERSION)
require 'gupshup-rb/util/configuration'

module Gupshup
  extend SingleForwardable
  
  autoload :HTTP, File.join(__dir__, 'gupshup-rb', 'http.rb')
  autoload :REST, File.join(__dir__, 'gupshup-rb', 'rest.rb')

  def_delegators :configuration, :src_name, :api_key, :http_client, :region, :edge, :logger
  ##
  # Pre-configure with account SID and auth token so that you don't need to
  # pass them to various initializers each time.
  def self.configure(&block)
    yield configuration
  end

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end

  private_class_method :configuration
end
