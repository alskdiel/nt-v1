class ScrapHouse < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_house
end
