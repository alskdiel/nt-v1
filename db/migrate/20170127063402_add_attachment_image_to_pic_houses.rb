class AddAttachmentImageToPicHouses < ActiveRecord::Migration
  def self.up
    change_table :pic_houses do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pic_houses, :image
  end
end
