class PicHouse < ActiveRecord::Base
  belongs_to :review_house
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/house_missing.jpeg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
