class ReviewHouse < ActiveRecord::Base
  has_many :pros_and_cons, :dependent => :delete_all
  has_many :pic_houses, :dependent => :delete_all
  has_many :upvote_houses
  has_many :scrap_houses
  has_many :comment_houses

  belongs_to :user

  def thumb_nail
    return PicHouse.where(review_house_id: self.id).take.image.url
  end

  def written_by
    return User.where(id: self.user_id).take.user_info.nickname
  end

  def avr_satis
    price = self.price_satisfaction
    residence = self.residence_satisfaction
    env = self.env_satisfaction

    return ((price + residence + env) / 3).round
  end

  def image_url
    pics = PicHouse.where(review_house_id: self.id)
    urls = []
    pics.each do |pic|
      urls.push(pic.image.url)
    end
    return urls
  end

  def pros
    pros = ProsAndCons.where(review_house_id: self.id, content_type: 1)
    ret = []
    pros.each do |pro|
      ret.push(pro.content)
    end
    return ret
  end

  def cons
    cons = ProsAndCons.where(review_house_id: self.id, content_type: 0)
    ret = []
    cons.each do |con|
      ret.push(con.content)
    end
    return ret
  end

  def cnt_upvotes
    UpvoteHouse.where(review_house_id: self.id).count
  end

  def cnt_scraps
    ScrapHouse.where(review_house_id: self.id).count
  end

  def comments (current_user = nil)
    comments = CommentHouse.where(review_house_id: self.id)
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
