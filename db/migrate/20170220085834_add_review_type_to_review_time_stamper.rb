class AddReviewTypeToReviewTimeStamper < ActiveRecord::Migration
  def change
    add_column :review_time_stampers, :review_type, :integer
  end
end
