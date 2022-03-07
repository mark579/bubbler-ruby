# frozen_string_literal: true

module Bubbler
  module Api
    require 'bubbler/railtie' if defined?(Rails)

    def self.post(simplecov_results)
      build_coverage_hash(simplecov_results.as_json)
    end

    def build_coverage_hash(simplecov_results)
      # simplecov_results.merge()
    end
  end
end
