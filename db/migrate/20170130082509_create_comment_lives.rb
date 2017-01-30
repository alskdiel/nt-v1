class CreateCommentLives < ActiveRecord::Migration
  def change
    create_table :comment_lives do |t|
      t.integer :review_life_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
