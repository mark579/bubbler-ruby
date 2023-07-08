# lib/railtie.rb
require 'bubbler_ruby'
require 'rails'

module Bubbler
  class Railtie < Rails::Railtie
    railtie_name :bubbler

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end