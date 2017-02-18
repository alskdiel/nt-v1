class AddHitCountToReviewHouse < ActiveRecord::Migration
  def change
    add_column :review_houses, :hit_count, :integer, default: 0
  end
end
