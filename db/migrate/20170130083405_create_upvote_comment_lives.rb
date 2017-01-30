class CreateUpvoteCommentLives < ActiveRecord::Migration
  def change
    create_table :upvote_comment_lives do |t|
      t.integer :comment_life_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
