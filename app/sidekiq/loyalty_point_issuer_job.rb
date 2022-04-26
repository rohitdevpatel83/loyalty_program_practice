class LoyaltyPointIssuerJob
  include Sidekiq::Job

  def perform(user_id, spending)
    user = User.find(user_id)
    spendings = user.spendings
    last_reward_date = user.last_rewarded_spending_date
    spendings = spendings.where("created_at > ?", last_reward_date) if last_reward_date
    amount_total = spendings.sum(:amount)

    if amount_total > 100
      spending.loyalty_points.create(
        points: loyalty_points(spending),
        spending: spending,
        expiry: (DateTime.now + 1.year),
        reward_title: 'standard'
      )
    end
  end

  def loyalty_points(spending)
    if spending.foreign_spending
      10
    else
      20
    end
  end
end
