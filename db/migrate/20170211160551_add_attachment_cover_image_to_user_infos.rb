class AddAttachmentCoverImageToUserInfos < ActiveRecord::Migration
  def self.up
    change_table :user_infos do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :user_infos, :cover_image
  end
end
