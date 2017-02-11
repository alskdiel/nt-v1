class MyReviewController < ApplicationController

  def my_reviews
    render "my_review/user_review"
  end

  def get_my_reviews
    houses = current_user.review_houses.all.order("created_at DESC")
    lives = current_user.review_lifes.all.order("created_at DESC")

    @reviews = []

    i = 0
    j = 0

    begin
      while true
        if houses[i].created_at > lives[j].created_at
          @reviews.push(houses[i])
          i += 1
        else
          @reviews.push(lives[j])
          j += 1
        end
      end
    rescue
      if houses[i].present?
        @reviews.push(houses[i])
      else
        @reviews.push(lives[j])
      end
    end
  end

  def get_my_review_info
    my_info = current_user.info_brief

    return render json: {
      ret: true,
      is_mypage: true,
      my_info: my_info
    }
  end

  def change_cover_img
    current_user.user_info.update(cover_image: params[:image])
    redirect_to action: 'my_reviews'
  end

  def user_reviews_h
    render "my_review/user_review"
  end

  def get_user_review_info_H
    review_id = params[:id]
    user_id = ReviewHouse.find(review_id).user_id

    my_info = User.find(user_id).info_brief

    is_mypage = (current_user.id == user_id)

    return render json: {
      ret: true,
      is_mypage: is_mypage,
      my_info: my_info
    }
  end

  def get_user_reviews_H
    review_id = params[:id]
    user_id = ReviewHouse.find(review_id).user_id
    
    houses = User.find(user_id).review_houses.all.order("created_at DESC")
    lives = User.find(user_id).review_lifes.all.order("created_at DESC")

    @reviews = []

    i = 0
    j = 0

    begin
      while true
        if houses[i].created_at > lives[j].created_at
          @reviews.push(houses[i])
          i += 1
        else
          @reviews.push(lives[j])
          j += 1
        end
      end
    rescue
      if houses[i].present?
        @reviews.push(houses[i])
      else
        @reviews.push(lives[j])
      end
    end
  end

  def user_reviews_l
    render "my_review/user_review"
  end

  def get_user_review_info_L
    review_id = params[:id]
    user_id = ReviewLife.find(review_id).user_id

    my_info = User.find(user_id).info_brief

    is_mypage = (current_user.id == user_id)

    return render json: {
      ret: true,
      is_mypage: is_mypage,
      my_info: my_info
    }
  end

  def get_user_reviews_L
    review_id = params[:id]
    user_id = ReviewLife.find(review_id).user_id
    
    houses = User.find(user_id).review_houses.all.order("created_at DESC")
    lives = User.find(user_id).review_lifes.all.order("created_at DESC")

    @reviews = []

    i = 0
    j = 0

    begin
      while true
        if houses[i].created_at > lives[j].created_at
          @reviews.push(houses[i])
          i += 1
        else
          @reviews.push(lives[j])
          j += 1
        end
      end
    rescue
      if houses[i].present?
        @reviews.push(houses[i])
      else
        @reviews.push(lives[j])
      end
    end
  end

end
