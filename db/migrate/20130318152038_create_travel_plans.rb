class CreateTravelPlans < ActiveRecord::Migration
  def change
    create_table :travel_plans do |t|
      t.integer :user_id
      t.integer :travel_group_id

      t.timestamps
    end

    add_index :travel_plans, :user_id

  end

end
