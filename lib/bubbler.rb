# frozen_string_literal: true

require_relative "bubbler/version"
require_relative "bubbler/api"

module Bubbler
  class Error < StandardError; end
  require 'bubbler/railtie' if defined?(Rails)

  def self.upload
    require 'simplecov'
    results = ::SimpleCov::ResultMerger.merged_result
    Api.post(results)
  end
end
