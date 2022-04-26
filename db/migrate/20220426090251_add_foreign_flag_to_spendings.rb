class AddForeignFlagToSpendings < ActiveRecord::Migration[7.0]
  def change
    add_column :spendings, :foreign_spending, :boolean
  end
end
