class HashTagRef < ActiveRecord::Base
  belongs_to :hash_tag
  belongs_to :review_life
end
