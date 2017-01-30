class ReviewLifeController < ApplicationController

  def index
    @reviews = ReviewLife.all
    render "pinterest_ui/index"
    # binding pry
  end

  def show
    @review = ReviewLife.find(params[:id])
    if user_signed_in?
      @upvote = current_user.has_upvoted?(params[:id])
      @scrap = current_user.has_scraped?(params[:id])
    else
      @upvote = @scrap = false
    end
    # return render json: { review: review.to_json }
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
