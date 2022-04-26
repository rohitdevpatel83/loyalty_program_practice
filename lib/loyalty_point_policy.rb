class LoyaltyPointPolicy
  attr_reader :user, :spending

  MINIMUM_SPENDING = 1_00
  MINIMUM_REBATABLE_SPENDING = 10
  FIRST_SIXTY_DAY_SPENDING = 1_000

  def initialize(user)
    @user = user
  end

  def coffee_reward?
    user.birthday_month? || user.coffee_rewardable?
  end

  def rebatable?
    user.rebatable_spendings.count > MINIMUM_REBATABLE_SPENDING
  end

  def movie_ticket?
    user.first_sixty_days_spendings > FIRST_SIXTY_DAY_SPENDING
  end

  def four_times_airport_lounge_access?
    user.gold_member?
  end

  def bonus_point_eligible?
    user.quarterly_spending
  end

  def generate_reward(spending_id)
    return nil unless rewardable?

    @spending = Spending.find(spending_id)
    reward = standard_reward

    if coffee_reward?
      reward[:reward_title] = 'free_coffee'
    end

    if rebatable?
      reward[:reward_title] = 'rebate'
    end

    if movie_ticket?
      reward[:reward_title] = 'movie_ticket'
    end

    reward
  end

  def quarterly_reward
    if user.gold_member?
      spending = user.last_spending
      reward = standard_reward
      reward[:reward_title] = 'airport_lounge_access'
      spending.loyalty_points.create(reward)
    end
  end

  private

  def rewardable?
    spendings = user.spendings
    spendings = spendings.where(
                            "created_at > ?",
                            user.last_reward_date
                          ) if user.last_reward_date

    spendings.sum(:amount) > 100
  end

  def standard_reward
    {
      points: spending.reward_points,
      expiry: (DateTime.now + 1.year),
      reward_title: 'standard'
    }
  end
end