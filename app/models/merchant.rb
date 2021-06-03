class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy

  def render_status
    if self.status
      {status: "Enabled", opposite: "Disabled"}
    else
      {status: "Disabled", opposite: "Enabled"}
    end
  end

end
