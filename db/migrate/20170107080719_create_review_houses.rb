class CreateReviewHouses < ActiveRecord::Migration
  def change
    create_table :review_houses do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :address, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :price_satisfaction, null: false
      t.integer :residence_satisfaction, null: false
      t.integer :env_satisfaction, null: false
      t.text :price_review, null: false
      t.text :residence_review, null: false
      t.text :env_review, null: false

      t.timestamps null: false
    end
  end
end
