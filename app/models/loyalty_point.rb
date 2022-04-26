class LoyaltyPoint < ApplicationRecord
  belongs_to :spending

  before_save :update_expiry

  def update_expiry
    self.expiry = DateTime.now + 1.year
  end
end
