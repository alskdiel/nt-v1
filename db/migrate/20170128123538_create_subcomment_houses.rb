class CreateSubcommentHouses < ActiveRecord::Migration
  def change
    create_table :subcomment_houses do |t|
      t.integer :comment_house_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
