class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def cents_to_dollars
    (self.to_f / 100).round(2)
  end
end
