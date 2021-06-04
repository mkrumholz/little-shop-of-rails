class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy

  def render_status
    if self.status
      {status: "Enabled", action: "Disable"}
    else
      {status: "Disabled", action: "Enable"}
    end
  end

  def self.enabled
    where(status: true)
  end
  
  def self.disabled
    where(status: false)
  end
end
