# frozen_string_literal: true

module Bubbler
  module Api
    require 'bubbler/railtie' if defined?(Rails)

    def self.post(results)
      build_coverage_hash(results.as_json)
    end

    def build_coverage_hash

    end
  end
end
