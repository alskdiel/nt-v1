class ReviewHousesController < ApplicationController
  before_action :set_review_house, only: [:show, :edit, :update, :destroy]

  # GET /review_houses
  # GET /review_houses.json
  def index
    # @reviews = ReviewHouse.all
    @mode = "oneroom"
    render "main/index"
    # binding pry
  end

  def get_reviews
    @reviews_all = ReviewHouse.all.order("created_at DESC")
    # return render json: { ret: true,
    #                       reviews: reviews}
    @reviews = {}
    @reviews[:new] = @reviews_all.clone
    @reviews[:best] = []

    temp = []
    reviews_best = @reviews_all.clone
    reviews_best.each do |review_best|
      temp.push(review: review_best,
                best_param: review_best.param_best)
    end

    temp.sort_by! { |o| o[:best_param] }.reverse!
    review_best = []
    temp.each do |o|
      @reviews[:best].push(o[:review])
    end
  end

  # GET /review_houses/1
  # GET /review_houses/1.json
  def show
    @review = ReviewHouse.find(params[:id])
    @auth = @review.auth(current_user)
    if user_signed_in?
      @upvote = current_user.has_upvoted_H?(params[:id])
      @scrap = current_user.has_scraped_H?(params[:id])
    else
      @upvote = @scrap = false
    end
    # return render json: { review: review.to_json }
  end

  # GET /review_houses/new
  def new
    if user_signed_in?
      @this_year = Time.now.year
      @min_year = 1900
    else
      redirect_to root_path
    end
  end

  # GET /review_houses/1/edit
  def edit
    if user_signed_in?
      @this_year = Time.now.year
      @min_year = 1900

      @review = ReviewHouse.find(params[:id])
      if current_user.id == @review.user_id

        @start_time = @review.start_time.strftime("%Y-%m")
        @start_time_y = @start_time.split("-")[0].to_i
        @start_time_m = @start_time.split("-")[1].to_i

        @end_time = @review.end_time.strftime("%Y-%m")
        @end_time_y = @end_time.split("-")[0].to_i
        @end_time_m = @end_time.split("-")[1].to_i

        @star_price_t = @review.price_satisfaction
        @star_residence_t = @review.residence_satisfaction
        @star_env_t = @review.env_satisfaction
        @star_price = [
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
        ]
        @star_residence = [
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
        ]
        @star_env = [
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
          {grey: nil, purple: 'none'},
        ]

        for i in 0..@star_price_t-1
          @star_price[i][:grey] = "none"
          @star_price[i][:purple] = nil
        end

        for i in 0..@star_residence_t-1
          @star_residence[i][:grey] = "none"
          @star_residence[i][:purple] = nil
        end

        for i in 0..@star_env_t-1
          @star_env[i][:grey] = "none"
          @star_env[i][:purple] = nil
        end

        @cons = @review.cons
        @pros = @review.pros
        else

        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # POST /review_houses
  # POST /review_houses.json
  def create
    if user_signed_in?
      review_house = current_user.review_houses.new(review_house_params)
      review_house.save

      pics = params[:pic_house]

      if pics.present?
        pics.each do |image|
          pic_house = review_house.pic_houses.create(:image => image)
        end
      end

      pros = params[:pros]
      cons = params[:cons]

      pros.each do |key, value|
        if value != ""
          ProsAndCons.create(review_house_id: review_house.id, content_type: 1, content: value)
        end
      end

      cons.each do |key, value|
        if value != ""
          ProsAndCons.create(review_house_id: review_house.id, content_type: 0, content: value)
        end
      end
    end

    redirect_to root_path
  end

  # PATCH/PUT /review_houses/1
  # PATCH/PUT /review_houses/1.json
  def update
    if user_signed_in?
      review_id = params[:id]
      review_house = ReviewHouse.find(review_id)

      if current_user.id == review_house.user_id
        pics = params[:pic_house]

        if pics.present?
          pics.each do |image|
            pic_house = review_house.pic_houses.take
            if pic_house.present?
              pic_house.image = image
            else
              pic_house = review_house.pic_houses.create(:image => image)
            end
            pic_house.save
          end
        end

        pncs = ProsAndCons.where(review_house_id: review_id)
        pncs.each do |pnc|
          pnc.delete
        end

        pros = params[:pros]
        cons = params[:cons]

        pros.each do |key, value|
          if value != ""
            ProsAndCons.create(review_house_id: review_house.id, content_type: 1, content: value)
          end
        end

        cons.each do |key, value|
          if value != ""
            ProsAndCons.create(review_house_id: review_house.id, content_type: 0, content: value)
          end
        end


        review_house.update(title: params[:review_house][:title],
                            latitude: params[:review_house][:latitude],
                            longtitude: params[:review_house][:longtitude],
                            address: params[:review_house][:address],
                            start_time: params[:review_house][:start_time],
                            end_time: params[:review_house][:end_time],
                            price_satisfaction: params[:review_house][:price_satisfaction],
                            residence_satisfaction: params[:review_house][:residence_satisfaction],
                            env_satisfaction: params[:review_house][:env_satisfaction],
                            price_review: params[:review_house][:price_review],
                            residence_review: params[:review_house][:residence_review],
                            env_review: params[:review_house][:env_review],
                           )
        review_house.save
      end

    end

    redirect_to root_path
  end

  # DELETE /review_houses/1
  # DELETE /review_houses/1.json
  def destroy
    if user_signed_in?
      review_id = params[:id]
      review = ReviewHouse.find(review_id)
      if review.present?
        if current_user.id == review.user_id
          review.delete
          return render json: { ret: true }
        end
      end

      return render json: { ret: false }
    else
      redirect_to root_path
    end
  end

  def submit_comment
    if user_signed_in?
      review_house_id = params[:review_house_id]
      content = params[:comment]
      CommentHouse.create(review_house_id: review_house_id, user_id: current_user.id, content: content)
      return render json: { current_user: true }
    else
      return render json: { current_user: false }
    end
  end

  def submit_subcomment
    if user_signed_in?
      comment_house_id = params[:comment_house_id]
      content = params[:comment]
      SubcommentHouse.create(comment_house_id: comment_house_id, user_id: current_user.id, content: content)
      return render json: { current_user: true }
    else
      return render json: { current_user: false }
    end
  end

  def delete_comment
    comment = CommentHouse.find(params[:comment_id])
    if user_signed_in?
      if current_user.id == comment.user_id
        comment.delete
        return render json: { ret: true }
      else
        return render json: { ret: false }
      end
    else
      return render json: { ret: false }
    end
  end

  def delete_subcomment
    subcomment = SubcommentHouse.find(params[:subcomment_id])
    if user_signed_in?
      if current_user.id == subcomment.user_id
        subcomment.delete
        return render json: { ret: true }
      else
        return render json: { ret: false }
      end
    else
      return render json: { ret: false }
    end
  end

  def get_comments
    review_house_id = params[:id]
    if user_signed_in?
      comments = ReviewHouse.find(review_house_id).comments (current_user)
    else
      comments = ReviewHouse.find(review_house_id).comments
    end
    return render json: { comments: comments }
  end

  def upvote
    if user_signed_in?
      review_house_id = params[:id]

      current_state = UpvoteHouse.where(review_house_id: review_house_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_upvoted: false }
      else
        UpvoteHouse.create(review_house_id: review_house_id, user_id: current_user.id)
        return render json: { current_user: true, has_upvoted: true }
      end
    else
      return render json: { current_user: false }
    end
  end

  def scrap
    if user_signed_in?
      review_house_id = params[:id]

      current_state = ScrapHouse.where(review_house_id: review_house_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_scraped: false }
      else
        ScrapHouse.create(review_house_id: review_house_id, user_id: current_user.id)
        return render json: { current_user: true, has_scraped: true }
      end
    else
      return render json: { current_user: false }
    end
  end

  def upvote_comment
    if user_signed_in?
      comment_house_id = params[:id]

      current_state = UpvoteCommentHouse.where(comment_house_id: comment_house_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_upvoted: false }
      else
        UpvoteCommentHouse.create(comment_house_id: comment_house_id, user_id: current_user.id)
        return render json: { current_user: true, has_upvoted: true }
      end
    else
      return render json: { current_user: false }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_house
      @review_house = ReviewHouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_house_params
      params.require(:review_house).permit(:title, :address, :latitude, :longtitude, :start_time, :end_time, :price_satisfaction, :residence_satisfaction, :env_satisfaction, :price_review, :residence_review, :env_review)
    end

end
