class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  after_initialize :init

  validates :name, presence: true

  def init
    self.status = false if self.status.nil?
  end

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
