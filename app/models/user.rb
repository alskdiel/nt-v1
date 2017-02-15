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
    return self.user_info.nickname
  end

  def sex
    if self.user_info.sex == 0
      return true
    else
      return false
    end
  end

  def cover_image
    return self.user_info.cover_image.url
  end

  def info_brief
    info = {
      nickname: self.nickname,
      isMale: self.sex,
      cover_image: self.cover_image
    }

    return info
  end

  def scraps
    scrap_houses = self.scrap_houses.all.order("created_at DESC")
    scrap_lives = self.scrap_lives.all.order("created_at DESC")

    houses = []
    lives = []

    scrap_houses.each do |scrap_house|
      houses.push(ReviewHouse.find(scrap_house.review_house_id))
    end
    scrap_lives.each do |scrap_life|
      lives.push(ReviewLife.find(scrap_life.review_life_id))
    end

    reviews = []

    houses.each do |house|
      reviews.push(house)
    end
    lives.each do |life|
      reviews.push(life)
    end

    reviews.sort_by! { |review| review.created_at }

    return reviews
  end

end
