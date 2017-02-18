class CreateReviewLifeHitLogs < ActiveRecord::Migration
  def change
    create_table :review_life_hit_logs do |t|
      t.integer :user_id
      t.integer :review_life_id

      t.timestamps null: false
    end
  end
end
