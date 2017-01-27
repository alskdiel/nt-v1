class ReviewHouse < ActiveRecord::Base
  has_many :pros_and_cons
  belongs_to :user
end
