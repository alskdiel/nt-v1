class CommentLife < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_life
  has_many :subcomment_lives
  has_many :upvote_comment_lives

  def upvotes
    return UpvoteCommentLife.where(comment_life_id: self.id).count
  end

  def has_upvoted? (user_id)
    return UpvoteCommentLife.where(comment_life_id: self.id, user_id: user_id).take.present?
  end

  def subcomments
    subcomments = []
    self.subcomment_lives.each do |subcomment|
      subcomments.push({
        written_by: User.find(subcomment.user_id).nickname,
        created_at: subcomment.created_at.strftime("%Y-%m-%d %H:%M"),
        content: subcomment.content
      })
    end

    return subcomments
  end
end
