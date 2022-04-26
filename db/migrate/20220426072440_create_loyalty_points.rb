class CreateLoyaltyPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_points do |t|
      t.float :points
      t.references :spending, null: false, foreign_key: true
      t.datetime :expiry

      t.timestamps
    end
  end
end
