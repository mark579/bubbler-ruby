# frozen_string_literal: true

require_relative "bubbler_ruby/version"
require_relative "bubbler_ruby/api"

module Bubbler
  class Error < StandardError; end
  require 'bubbler_ruby/railtie' if defined?(Rails)

  def self.upload
    require 'simplecov'
    results = ::SimpleCov::ResultMerger.merged_result
    Api.post(results)
  end
end
