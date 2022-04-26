class RemoveCountryFromSpendings < ActiveRecord::Migration[7.0]
  def change
    remove_column :spendings, :country
  end
end
