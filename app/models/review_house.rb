class ReviewHouse < ActiveRecord::Base
  has_many :pros_and_cons, :dependent => :delete_all
  has_many :pic_houses, :dependent => :delete_all
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
end
