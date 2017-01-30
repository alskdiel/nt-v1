class ReviewLifeController < ApplicationController

  def index
    @reviews = ReviewLife.all
    render "pinterest_ui/index"
    # binding pry
  end

  def show
    @review = ReviewLife.find(params[:id])
    if user_signed_in?
      @upvote = current_user.has_upvoted_L?(params[:id])
      @scrap = current_user.has_scraped_L?(params[:id])
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

  def upvote
    if user_signed_in?
      review_life_id = params[:id]

      current_state = UpvoteLife.where(review_life_id: review_life_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_upvoted: false }
      else
        UpvoteLife.create(review_life_id: review_life_id, user_id: current_user.id)
        return render json: { current_user: true, has_upvoted: true }
      end
    else
      return render json: { current_user: false }
    end
  end

  def scrap
    if user_signed_in?
      review_life_id = params[:id]

      current_state = ScrapLife.where(review_life_id: review_life_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { curent_user: true, has_scraped: false }
      else
        ScrapLife.create(review_life_id: review_life_id, user_id: current_user.id)
        return render json: { current_user: true, has_scraped: true }
      end
    else
      return render json: { current_user: false }
    end
  end

  private
  def review_life_params
    params.require(:review_life).permit(:title, :content, :image)
  end

end
