class CommentHouse < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_house
  has_many :subcomment_houses
end
