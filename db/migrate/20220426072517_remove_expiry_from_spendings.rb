class RemoveExpiryFromSpendings < ActiveRecord::Migration[7.0]
  def change
    remove_column :spendings, :expiry
  end
end
