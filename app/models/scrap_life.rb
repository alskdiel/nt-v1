class ScrapLife < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_life
end
