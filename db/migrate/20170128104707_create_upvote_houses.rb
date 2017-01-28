class CreateUpvoteHouses < ActiveRecord::Migration
  def change
    create_table :upvote_houses do |t|
      t.integer :review_house_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
