class ReviewLifeController < ApplicationController

  def index
    @reviews = ReviewLife.all
    render "pinterest_ui/index"
    # binding pry
  end

  def create
    review_life = current_user.review_lifes.new(review_life_params)
    review_life.save

    redirect_to root_path
  end

  private
  def review_life_params
    params.require(:review_life).permit(:title, :content, :image)
  end

end
