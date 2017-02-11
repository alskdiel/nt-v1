class MyReviewController < ApplicationController

  def my_reviews
    render "my_review/user_review"
  end

  def get_my_reviews
    houses = current_user.review_houses.all.order("created_at DESC")
    lives = current_user.review_lifes.all.order("created_at DESC")

    @reviews = []

    i = 0
    if houses.present?
      houses.each do |house|
        begin
          while house.created_at < lives[i].created_at do
            @reviews.push(lives[i])
            i += 1
          end
        rescue
        end
        @reviews.push(house)
      end
    else
      lives.each do |life|
        begin
          while life.created_at < houses[i].created_at do
            @reviews.push(houses[i])
            i += 1
          end
        rescue
        end
        @reviews.push(life)
      end
    end
  end

  def get_my_review_info
    my_info = current_user.info_brief

    return render json: {
      ret: true,
      my_info: my_info
    }
  end

  def user_reviews_h
    render "my_review/user_review"
  end

  def get_user_review_info_H
    review_id = params[:id]
    user_id = ReviewHouse.find(review_id).user_id

    my_info = User.find(user_id).info_brief

    return render json: {
      ret: true,
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
    if houses.present?
      houses.each do |house|
        begin
          while house.created_at < lives[i].created_at do
            @reviews.push(lives[i])
            i += 1
          end
        rescue
        end
        @reviews.push(house)
      end
    else
      lives.each do |life|
        begin
          while life.created_at < houses[i].created_at do
            @reviews.push(houses[i])
            i += 1
          end
        rescue
        end
        @reviews.push(life)
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

    return render json: {
      ret: true,
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

    if houses.present?
      houses.each do |house|
        begin
          while house.created_at < lives[i].created_at do
            @reviews.push(lives[i])
            i += 1
          end
        rescue
        end
        @reviews.push(house)
      end
    else
      lives.each do |life|
        begin
          while life.created_at < houses[i].created_at do
            @reviews.push(houses[i])
            i += 1
          end
        rescue
        end
        @reviews.push(life)
      end
    end
  end

end
