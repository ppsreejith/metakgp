class CreateTravelSegments < ActiveRecord::Migration
  def change
    create_table :travel_segments do |t|
      t.string :from
      t.string :to
      t.datetime :at
      t.integer :travel_plan_id

      t.timestamps
    end

    add_index :travel_segments, :travel_plan_id
  end
end
