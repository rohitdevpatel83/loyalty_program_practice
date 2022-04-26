class Spending < ApplicationRecord
  belongs_to :user
  has_many :loyalty_points

  after_create :issue_loyality_points

  def issue_loyality_points
    LoyaltyPointIssuerJob.perform_async(user.id, self.id)
  end

  def reward_points
    points = self.amount / 10
    points  = (points * 2) if self.foreign_spending
    points
  end
end
