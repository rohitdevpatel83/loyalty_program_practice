class LoyaltyPointPolicy
  attr_reader :user

  MINIMUM_PURCHASE = 1_00

  def initialize(user)
    @user = user
  end

  def coffee_reward?
    user.birthday_month? || user.coffee_rewardable?
  end

  def rebatable?
    user.rebatable_spendings.count > 10
  end

  def movie_ticket?
    user.last_sixty_days_spendings > 1_000
  end

  def four_times_airport_lounge_access?
    user.gold_member?
  end

  def bonus_point_eligible?
    user.quarterly_spending
  end
end