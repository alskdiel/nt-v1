class MainController < ApplicationController

  def index
    @mode = "all"
    render "main/index"
  end

  def get_reviews
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

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


  def search_item

  end

  def user_signed_in
    return render json: { user_signed_in: user_signed_in? }
  end
end
