class MyReviewController < ApplicationController

  def my_reviews
    render "my_review/user_review"
  end

  def get_my_reviews
    houses = current_user.review_houses.all.order("created_at DESC")
    lives = current_user.review_lifes.all.order("created_at DESC")

    @reviews = []

    i = 0
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
  end

  def get_my_review_info
    my_info = current_user.info_brief

    return render json: {
      ret: true,
      my_info: my_info
    }
  end

end
