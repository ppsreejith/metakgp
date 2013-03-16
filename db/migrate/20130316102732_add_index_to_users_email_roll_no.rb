class AddIndexToUsersEmailRollNo < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true
  	add_index :users, :roll_no, unique: true
  end
end
