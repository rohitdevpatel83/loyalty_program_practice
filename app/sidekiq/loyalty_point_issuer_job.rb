class LoyaltyPointIssuerJob
  include Sidekiq::Job

  def perform(user_id, spending_id)
    user = User.find(user_id)
    spending = Spending.find(spending_id)
    policy = LoyaltyPointPolicy.new(user)
    loyalty_point = policy.generate_reward(spending_id)

    if loyalty_point
      spending.loyalty_points.create(loyalty_point)
    end
  end
end
