class ReviewHouse < ActiveRecord::Base
  has_many :pros_and_cons, :dependent => :delete_all
  has_many :pic_houses, :dependent => :delete_all
  has_many :upvote_houses
  has_many :scrap_houses
  has_many :comment_houses
  has_many :review_house_hit_logs

  belongs_to :user

  def is_house_review?
    return true
  end

  def auth (current_user = nil)
    if current_user != nil
      return current_user.id == self.user_id
    else
      return false
    end
  end

  def thumb_nail
    begin
      return self.pic_houses.first.image.url
    rescue
      return '/images/original/house_missing.jpeg'
    end
    # return PicHouse.where(review_house_id: self.id).take.image.url
  end

  def written_by
    return User.where(id: self.user_id).take.user_info.nickname
  end

  def avr_satis
    price = self.price_satisfaction
    residence = self.residence_satisfaction
    env = self.env_satisfaction

    return ((price + residence + env) / 3.0).round
  end

  def image_url
    pics = self.pic_houses
    # pics = PicHouse.where(review_house_id: self.id)
    if pics.present?
      urls = []
      pics.each do |pic|
        urls.push(pic.image.url)
      end
      return urls
    else
      return ['/images/original/house_missing.jpeg']
    end
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
    return self.upvote_houses.count
    # UpvoteHouse.where(review_house_id: self.id).count
  end

  def cnt_scraps
    return self.scrap_houses.count
    # ScrapHouse.where(review_house_id: self.id).count
  end

  def param_best
    return self.cnt_upvotes + self.cnt_scraps
  end

  def comments (current_user = nil)
    comments = self.comment_houses
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
        subcomment_cnt: comment.subcomment_houses.count,
        subcomments: comment.subcomments(current_user)
      })
    end

    return ret
  end

end
