class ReviewLife < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def is_house_review?
    return false
  end

  def thumb_nail
    return self.image.url
  end

  def written_by
    return User.where(id: self.user_id).take.user_info.nickname
  end

  # def cnt_upvotes
  #   UpvoteLife.where(review_life_id: self.id).count
  # end
  #
  # def cnt_scraps
  #   ScrapLife.where(review_life_id: self.id).count
  # end
end
