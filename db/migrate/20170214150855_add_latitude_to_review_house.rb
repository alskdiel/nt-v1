class AddLatitudeToReviewHouse < ActiveRecord::Migration
  def change
    add_column :review_houses, :latitude, :float
  end
end
