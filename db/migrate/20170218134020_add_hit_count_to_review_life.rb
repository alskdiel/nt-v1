class AddHitCountToReviewLife < ActiveRecord::Migration
  def change
    add_column :review_lives, :hit_count, :integer, default: 0
  end
end
