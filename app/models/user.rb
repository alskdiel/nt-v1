class User < ActiveRecord::Base
  has_many :review_houses
  has_many :upvote_houses
  has_many :scrap_houses
  has_many :comment_houses
  has_many :subcomment_houses
  has_one :user_info
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def has_upvoted? (review_house_id)
    return self.upvote_houses.where(review_house_id: review_house_id).take.present?
  end

  def has_scraped? (review_house_id)
    return self.scrap_houses.where(review_house_id: review_house_id).take.present?
  end

  def nickname
    return UserInfo.where(user_id: self.id).take.nickname
  end

end
