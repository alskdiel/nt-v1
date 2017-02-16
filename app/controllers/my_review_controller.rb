class MyReviewController < ApplicationController

  def my_reviews
    if user_signed_in?
      render "my_review/user_review"
    else
      redirect_to root_path
    end
  end

  def get_my_reviews
    if user_signed_in?
      houses = current_user.review_houses.all.order("created_at DESC")
      lives = current_user.review_lifes.all.order("created_at DESC")

      @reviews = []
      houses.each do |house|
        @reviews.push(house)
      end
      lives.each do |life|
        @reviews.push(life)
      end

      @reviews.sort_by! { |review| review.created_at }.reverse!
    else
      # redirect_to root_path
    end
  end

  def get_my_review_info
    if user_signed_in?
      my_info = current_user.info_brief

      return render json: {
        ret: true,
        is_mypage: true,
        my_info: my_info
      }
    else
      return render json: {
        ret: false
      }
    end
  end

  def change_cover_img
    if user_signed_in?
      current_user.user_info.update(cover_image: params[:image])
    end
    redirect_to action: 'my_reviews'
  end

  def my_scraps
    render "my_review/my_scrap"
  end

  def get_my_scraps
    @reviews = current_user.scraps
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

    houses.each do |house|
      @reviews.push(house)
    end
    lives.each do |life|
      @reviews.push(life)
    end

    @reviews.sort_by! { |review| review.created_at }.reverse!
  end

  def user_reviews_l
    render "my_review/user_review"
  end

  def get_user_review_info_L
    review_id = params[:id]
    user_id = ReviewLife.find(review_id).user_id

    my_info = User.find(user_id).info_brief

    if user_signed_in?
      is_mypage = (current_user.id == user_id)
    else
      is_mypage = false
    end

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
    houses.each do |house|
      @reviews.push(house)
    end
    lives.each do |life|
      @reviews.push(life)
    end

    @reviews.sort_by! { |review| review.created_at }.reverse!

  end

end
