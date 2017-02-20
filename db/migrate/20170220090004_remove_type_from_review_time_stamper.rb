class RemoveTypeFromReviewTimeStamper < ActiveRecord::Migration
  def change
    remove_column :review_time_stampers, :type, :integer
  end
end
