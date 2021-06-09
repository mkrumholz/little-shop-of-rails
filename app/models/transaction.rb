class Transaction < ApplicationRecord
  enum result: [:failure, :success]

  belongs_to :invoice

end
