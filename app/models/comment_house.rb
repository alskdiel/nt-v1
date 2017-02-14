class CommentHouse < ActiveRecord::Base
  belongs_to :user
  belongs_to :review_house
  has_many :subcomment_houses
  has_many :upvote_comment_houses

  def upvotes
    return UpvoteCommentHouse.where(comment_house_id: self.id).count
  end

  def has_upvoted? (user_id)
    return UpvoteCommentHouse.where(comment_house_id: self.id, user_id: user_id).take.present?
  end

  def subcomments
    subcomments = []
    self.subcomment_houses.each do |subcomment|
      subcomments.push({
        written_by: User.find(subcomment.user_id).nickname,
        created_at: subcomment.created_at.strftime("%Y-%m-%d %H:%M"),
        content: subcomment.content
      })
    end

    return subcomments
  end
end
