class LoyaltyPoint < ApplicationRecord
  belongs_to :spending

  before_save :update_expiry
  before_save :check_point_type

  enum reward_title: [:standard, :free_coffee, :rebate, :movie_ticket, :airport_lounge_access]

  def update_expiry
    self.expiry = DateTime.now + 1.year
  end

  def check_point_type
    if self.reward_title != 'standard'
      self.points = 0
    end
  end
end
