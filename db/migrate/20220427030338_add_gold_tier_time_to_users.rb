class AddGoldTierTimeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gold_tier_time, :datetime
  end
end
