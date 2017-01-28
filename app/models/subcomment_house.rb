class SubcommentHouse < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment_house
end
