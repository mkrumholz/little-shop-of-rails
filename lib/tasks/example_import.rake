require 'csv'
require './app/models/customer'
require './app/models/application_record'

namespace :csv_load do
  task :customers do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      # require "pry"; binding.pry
      Customer.create!(row.to_hash)
    end
  end

  task :invoice_items do

  end

  task :invoices do
    #
  end

  task :items do
    #
  end

  task :merchants do
    #
  end

  task :transactions do
    #
  end

  task :all do
    ENV['ALL'] = 'true'
    Rake::Task["csv_load:customers"].execute
    Rake::Task["csv_load:invoice_items"].execute
  end
end
  #
  # file = "db/teams.csv"
  #
  # CSV.foreach(file, :headers => true) do |row|
  #   Team.create {
  #     :name => row[1],
  #     :league => row[2],
  #     :some_other_data => row[4]
  #   }
  # end
  #
  # CSV.foreach(filename, headers: true) do |row|
  #   Moulding.create!(row.to_hash)
  # end
