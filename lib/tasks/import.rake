require 'csv'

namespace :csv_load do
  task customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  task invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      if row[5] == 'pending'
        status = 0
      elsif row[5] == 'packaged'
        status = 1
      elsif row[5] == 'shipped'
        status = 2
      end
      InvoiceItem.create!({
        :id => row[0],
        :item_id => row[1],
        :invoice_id => row[2],
        :quantity => row[3],
        :unit_price => row[4],
        :status => status,
        :created_at => row[6],
        :updated_at => row[7]
      })
    end
  end

  task invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      if row[2] == 'in progress'
        status = 0
      elsif row[2] == 'completed'
        status = 1
      elsif row[2] == 'cancelled'
        status = 2
      end
      Invoice.create!({
        :id => row[0],
        :customer_id => row[1],
        :status => status,
        :created_at => row[3],
        :updated_at => row[4]
      })
    end
  end

  task items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  task merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      if row[4] == 'failed'
        result = 0
      elsif row[4] == 'success'
        result = 1
      end
      Transaction.create!({
        :id => row[0],
        :invoice_id => row[1],
        :credit_card_number => row[2],
        :credit_card_expiration_date => row[3],
        :result => result,
        :created_at => row[5],
        :updated_at => row[6]
      })
    end
  end

  task all: :environment do
    Rake::Task["csv_load:customers"].execute
    Rake::Task["csv_load:merchants"].execute
    Rake::Task["csv_load:items"].execute
    Rake::Task["csv_load:invoices"].execute
    Rake::Task["csv_load:transactions"].execute
    Rake::Task["csv_load:invoice_items"].execute
  end
end
