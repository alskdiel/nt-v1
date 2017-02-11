class MainController < ApplicationController

  def index
    render "main/index"
  end

  def get_reviews
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

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

    # return render json: { ret: true,
    #                       reviews: reviews }

  end


  def search_item

  end

end
