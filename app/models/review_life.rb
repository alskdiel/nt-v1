class ReviewLife < ActiveRecord::Base
  has_many :upvote_lives
  has_many :scrap_lives
  has_many :comment_lives

  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def is_house_review?
    return false
  end

  def thumb_nail
    if self.image.url != '/images/original/missing.png'
      return self.image.url
    else
      return nil
    end
  end

  def image_url
    self.thumb_nail
  end

  def written_by
    return User.where(id: self.user_id).take.user_info.nickname
  end

  def cnt_upvotes
    UpvoteLife.where(review_life_id: self.id).count
  end

  def cnt_scraps
    ScrapLife.where(review_life_id: self.id).count
  end

  def comments (current_user = nil)
    comments = self.comment_lives
    ret = []

    comments.each do |comment|
      if current_user != nil
        has_upvoted = comment.has_upvoted?(current_user.id)
      else
        has_upvoted = false
      end
      ret.push({
        id: comment.id,
        written_by: User.find(comment.user_id).nickname,
        content: comment.content,
        created_at: comment.created_at.strftime("%Y-%m-%d"),
        upvote_count: comment.upvotes,
        has_upvoted: has_upvoted
      })
    end

    return ret
  end
end
