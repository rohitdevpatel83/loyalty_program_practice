class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spendings
  has_many :loyalty_points, through: :spendings

  scope :new_gold_tier_members, -> { where(gold_tier_time: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day) }

  def self.countries
    CS.countries.collect { |country| [country[1], country[0]]}
  end

  def last_reward_date
    not_expired_loyalty_points&.order(created_at: :desc)&.first&.spending&.created_at
  end

  def birthday_month?
    self.dob.month == Date.today.month
  end

  def coffee_rewardable?
    points = not_expired_loyalty_points.where(created_at: Date.today.beginning_of_month..Date.today)
    points.sum(:amount) > 100
  end

  def rebatable_spendings
    spendings.where("amount > ? AND created_at > ?", 100, last_rebate_date)
  end

  def first_sixty_days_spendings
    spendings.where("created_at > ?", (created_at + 60.days))&.sum(:amount)
  end

  def quarterly_spending
    spendings.where("created_at > ?", 3.months.ago).sum(:amount)
  end

  def standard_member?
    loyalty_tier =='standard'
  end

  def gold_member?
    loyalty_tier =='gold'
  end

  def platinum_member?
    loyalty_tier =='platinum'
  end

  def total_rewards_earned
    not_expired_loyalty_points.sum(:points)
  end

  def last_spending
    spendings.order(created_at: :desc).first
  end

  private

  def last_rebate_date
    not_expired_loyalty_points.where(reward_title: 'rebate').order(created_at: :desc).first.created_at
  end

  def loyalty_tier
    points = not_expired_loyalty_points.sum(:points)

    if points < 1000
      'standard'
    elsif points < 5000
      'gold'
    elsif points > 5000
      'platinum'
    end
  end

  def not_expired_loyalty_points
    loyalty_points.where(created_at: 1.year.ago..DateTime.now)
  end
end
