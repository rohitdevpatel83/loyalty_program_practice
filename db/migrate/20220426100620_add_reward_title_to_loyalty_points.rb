class AddRewardTitleToLoyaltyPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :loyalty_points, :reward_title, :string
  end
end
