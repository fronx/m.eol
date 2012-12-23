require 'mysql'
require 'yaml'
require 'timeout'
require 'analytics/graphite'

module Eol
  class Configuration
    attr_reader :config

    def initialize(config_hash)
      @config = config_hash
    end
  end
end
