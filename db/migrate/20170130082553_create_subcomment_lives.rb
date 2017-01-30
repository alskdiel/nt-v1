class CreateSubcommentLives < ActiveRecord::Migration
  def change
    create_table :subcomment_lives do |t|
      t.integer :comment_life_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
