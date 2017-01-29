class AddAttachmentImageToReviewLives < ActiveRecord::Migration
  def self.up
    change_table :review_lives do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :review_lives, :image
  end
end
