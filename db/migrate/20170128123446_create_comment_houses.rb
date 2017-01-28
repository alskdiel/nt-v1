class CreateCommentHouses < ActiveRecord::Migration
  def change
    create_table :comment_houses do |t|
      t.integer :review_house_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
