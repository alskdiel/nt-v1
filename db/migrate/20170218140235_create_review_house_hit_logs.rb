class CreateReviewHouseHitLogs < ActiveRecord::Migration
  def change
    create_table :review_house_hit_logs do |t|
      t.integer :user_id
      t.integer :review_house_id

      t.timestamps null: false
    end
  end
end
