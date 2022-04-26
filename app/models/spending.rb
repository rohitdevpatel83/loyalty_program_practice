class Spending < ApplicationRecord
  belongs_to :user
  has_many :loyalty_points

  after_create :issue_loyality_points

  def issue_loyality_points
    LoyaltyPointIssuerJob.perform_async(user.id, self)
  end
end
