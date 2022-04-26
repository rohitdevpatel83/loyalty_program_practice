class QuarterlyBonusJob
  include Sidekiq::Job

  def perform
    User.new_gold_tier_members.find_in_batches do |group|
      group.each do |user|
        policy = LoyaltyPointPolicy.new(user)
        policy.quarterly_reward
      end
    end
  end
end
