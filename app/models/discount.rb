class Discount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name, :percentage, :quantity_threshold
  validates_uniqueness_of :name
  validates_numericality_of :percentage, less_than_or_equal_to: 1.0
  validates_numericality_of :percentage,greater_than_or_equal_to: 0.0
  validates_numericality_of :quantity_threshold, only_integer: true
end
