class CreateReviewTimeStampers < ActiveRecord::Migration
  def change
    create_table :review_time_stampers do |t|
      t.integer :review_id
      t.integer :type

      t.timestamps null: false
    end
  end
end
