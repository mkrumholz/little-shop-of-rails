class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy

  def render_status
    if self.status
      "Enabled"
    else
      "Disabled"
    end
  end

end
