class ChangeRewardTitleTypeInLoyaltyPoints < ActiveRecord::Migration[7.0]
  def change
    change_column :loyalty_points, :reward_title, :integer
  end
end
