require_relative 'config/application'

Rails.application.load_tasks

namespace :test do
  desc "Run all tests"
  task all: [:unit, :acceptance]

  desc "Run unit tests"
  task :unit do
    sh 'rspec spec/* --format documentation --exclude-pattern spec/acceptance/*'
  end

  desc "Run acceptance tests"
  task :acceptance do
    sh 'rspec spec/acceptance/* --format documentation'
  end
end

task :default => ['test:all']
