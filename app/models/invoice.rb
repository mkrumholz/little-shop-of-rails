class Invoice < ApplicationRecord
  enum status: [:in_progress, :completed, :cancelled]

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions



  # In that section I see a list of the ids of all invoices
  # That have items that have not yet been shipped

  def self.unshipped_items
    joins(:invoice_items).where('invoice_items.status != 2').select('invoices.*').group('invoices.id').distinct
  end
end
