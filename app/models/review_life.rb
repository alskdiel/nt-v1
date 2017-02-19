class ReviewLife < ActiveRecord::Base
  has_many :upvote_lives
  has_many :scrap_lives
  has_many :comment_lives
  has_many :hash_tag_refs

  has_many :review_life_hit_logs
  has_many :linkto_hit_logs

  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def is_house_review?
    return false
  end

  def auth (current_user = nil)
    if current_user != nil
      return current_user.id == self.user_id
    else
      return false
    end
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

  def param_best
    return self.cnt_upvotes + self.cnt_scraps
  end

  def comments (current_user = nil)
    comments = self.comment_lives
    ret = []

    comments.each do |comment|
      auth = false
      if current_user != nil
        has_upvoted = comment.has_upvoted?(current_user.id)
        if current_user.id == comment.user_id
          auth = true
        end
      else
        has_upvoted = false
      end

      ret.push({
        id: comment.id,
        user_id: comment.user_id,
        auth: auth,
        written_by: User.find(comment.user_id).nickname,
        content: comment.content,
        created_at: comment.created_at.strftime("%Y-%m-%d %H:%M"),
        upvote_count: comment.upvotes,
        has_upvoted: has_upvoted,
        subcomment_cnt: comment.subcomment_lives.count,
        subcomments: comment.subcomments(current_user)
      })
    end

    return ret
  end

  def hash_tag_str
    hash_tag_str = ""
    refs = self.hash_tag_refs
    refs.each do |ref|
      hash_tag_str = hash_tag_str + "##{HashTag.find(ref.hash_tag_id).keyword} "
    end

    return hash_tag_str
  end

end
