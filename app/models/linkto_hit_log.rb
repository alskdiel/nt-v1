class LinktoHitLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_life
end
