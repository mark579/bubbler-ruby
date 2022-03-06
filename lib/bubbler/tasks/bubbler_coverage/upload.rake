namespace :bubbler do
  desc "Upload Simplecov Results to Bubbler"
  task upload: :environment do
    puts "Starting Upload"
    Bubbler.upload
  end
end