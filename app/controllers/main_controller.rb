class MainController < ApplicationController

  def index
    render "pinterest_ui/index"
  end

  def get_reviews
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

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

    # return render json: { ret: true,
    #                       reviews: reviews }

  end

  def search_item

  end

end
