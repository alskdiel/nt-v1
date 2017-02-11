class User < ActiveRecord::Base
  has_many :review_houses
  has_many :review_lifes
  has_many :upvote_houses
  has_many :scrap_houses
  has_many :upvote_lives
  has_many :scrap_lives
  has_many :comment_houses
  has_many :subcomment_houses
  has_many :comment_lives
  has_many :subcomment_lives
  has_many :upvote_comment_houses
  has_many :upvote_comment_lives
  has_one :user_info
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def has_upvoted_H? (review_house_id)
    return self.upvote_houses.where(review_house_id: review_house_id).take.present?
  end

  def has_scraped_H? (review_house_id)
    return self.scrap_houses.where(review_house_id: review_house_id).take.present?
  end

  def has_upvoted_L? (review_life_id)
    return self.upvote_lives.where(review_life_id: review_life_id).take.present?
  end

  def has_scraped_L? (review_life_id)
    return self.scrap_lives.where(review_life_id: review_life_id).take.present?
  end

  def nickname
    return UserInfo.where(user_id: self.id).take.nickname
  end

  def info_brief
    info = {
      nickname: self.nickname,
      cnt_post: self.review_houses.count + self.review_lifes.count
    }

    return info
  end

end
