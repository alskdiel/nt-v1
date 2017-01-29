class ReviewHousesController < ApplicationController
  before_action :set_review_house, only: [:show, :edit, :update, :destroy]

  # GET /review_houses
  # GET /review_houses.json
  def index
    @review_houses = ReviewHouse.all
    # binding pry
  end

  # GET /review_houses/1
  # GET /review_houses/1.json
  def show
    @review = ReviewHouse.find(params[:id])
    if user_signed_in?
      @upvote = current_user.has_upvoted?(params[:id])
      @scrap = current_user.has_scraped?(params[:id])
    else
      @upvote = @scrap = false
    end
    # return render json: { review: review.to_json }
  end

  # GET /review_houses/new
  def new
    # @review_house = ReviewHouse.new
  end

  # GET /review_houses/1/edit
  def edit
  end

  # POST /review_houses
  # POST /review_houses.json
  def create
    review_house = current_user.review_houses.new(review_house_params)
    review_house.save

    params[:pic_house].each do |image|
      pic_house = review_house.pic_houses.create(:image => image)
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

    redirect_to root_path



    # respond_to do |format|
    #   if ret
    #     format.html { redirect_to @review_house, notice: 'Review house was successfully created.' }
    #     format.json { render :show, status: :created, location: @review_house }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @review_house.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /review_houses/1
  # PATCH/PUT /review_houses/1.json
  def update
    respond_to do |format|
      if @review_house.update(review_house_params)
        format.html { redirect_to @review_house, notice: 'Review house was successfully updated.' }
        format.json { render :show, status: :ok, location: @review_house }
      else
        format.html { render :edit }
        format.json { render json: @review_house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_houses/1
  # DELETE /review_houses/1.json
  def destroy
    @review_house.destroy
    respond_to do |format|
      format.html { redirect_to review_houses_url, notice: 'Review house was successfully destroyed.' }
      format.json { head :no_content }
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
        return render json: { curent_user: true, has_scraped: false }
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
      params.require(:review_house).permit(:title, :address, :start_time, :end_time, :price_satisfaction, :residence_satisfaction, :env_satisfaction, :price_review, :residence_review, :env_review)
    end

end
