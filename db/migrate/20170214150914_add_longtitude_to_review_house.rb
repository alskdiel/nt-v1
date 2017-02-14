class AddLongtitudeToReviewHouse < ActiveRecord::Migration
  def change
    add_column :review_houses, :longtitude, :float
  end
end
