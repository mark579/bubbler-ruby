# frozen_string_literal: true

require 'uri'
require 'net/http'

module Bubbler
  module Api
    require 'bubbler_ruby/railtie' if defined?(Rails)

    def self.post(simplecov_results)
      body = request_body(simplecov_results.as_json)

      uri = URI('http://bubbler-dev.us-west-2.elasticbeanstalk.com/api/coverage/simplecov')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false

      request = Net::HTTP::Post.new(uri.path, 
        {
          'Content-Type' => 'application/json'
        }
      )
      puts body
      if body[:results].nil?
        puts "No results found from SimpleCov"
        return
      end
      request.body = body.to_json
      response = http.request(request)
    end

    def self.request_body(simplecov_results)
      circleci_body(simplecov_results)
    end

    def self.circleci_body(simplecov_results)
      {
        branch: ENV['CIRCLE_BRANCH'],
        commit_sha: ENV['CIRCLE_SHA1'],
        slug: circle_slug,
        pr: ENV['CIRCLE_PR_NUMBER'],
        results: simplecov_results
      }
    end

    # CIRCLE_PROJECT_REPONAME=rails-bubbler-test
    # CIRCLE_PROJECT_USERNAME=mark579
    # CIRCLE_REPOSITORY_URL=git@github.com:mark579/rails-bubbler-test.git
    def self.circle_slug
      if !ENV['CIRCLE_PROJECT_REPONAME'].nil?
        ENV['CIRCLE_PROJECT_USERNAME'] + '/' + ENV['CIRCLE_PROJECT_REPONAME']
      else
        ENV['CIRCLE_REPOSITORY_URL'].gsub(/^.*:/, '').gsub(/\.git$/, '')
      end
    end
  end
end
