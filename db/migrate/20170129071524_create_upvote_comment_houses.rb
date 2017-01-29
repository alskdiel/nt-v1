class CreateUpvoteCommentHouses < ActiveRecord::Migration
  def change
    create_table :upvote_comment_houses do |t|
      t.integer :comment_house_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
