class MainController < ApplicationController

  def index
    @houses = ReviewHouse.all.order("created_at DESC")
    @lives = ReviewLife.all.order("created_at DESC")

    @reviews = []

    i = 0
    @houses.each do |house|
      begin
        while house.created_at < @lives[i].created_at do
          @reviews.push(@lives[i])
          i += 1
        end
      rescue
      end
      @reviews.push(house)
    end

    render "pinterest_ui/index"
  end

  def search_item

  end

end
