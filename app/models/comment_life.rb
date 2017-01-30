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

end
