class ReviewLifeController < ApplicationController

  def index
    # @reviews = ReviewLife.all
    @mode = "life"
    render "main/index"
    # binding pry
  end

  def get_reviews
    @reviews_all = ReviewLife.all.order("created_at DESC");
    # return render json: { ret: true,
    #                       reviews: reviews}
    @reviews = {}
    @reviews[:new] = @reviews_all.clone
    # ReviewLifeHelper.calc_best
    @reviews[:best] = JSON[$redis.get("life_best")]

    # temp = []
    # reviews_best = @reviews_all.clone
    # reviews_best.each do |review_best|
    #   temp.push(review: review_best,
    #             best_param: review_best.param_best)
    # end
    #
    # temp.sort_by! { |o| o[:best_param] }.reverse!
    # review_best = []
    # temp.each do |o|
    #   @reviews[:best].push(o[:review])
    # end
  end

  def show
    @review = ReviewLife.find(params[:id])

    hit_count = @review.hit_count
    hit_count += 1
    @review.update(hit_count: hit_count)

    @auth = @review.auth(current_user)
    if user_signed_in?
      @upvote = current_user.has_upvoted_L?(params[:id])
      @scrap = current_user.has_scraped_L?(params[:id])
    else
      @upvote = @scrap = false
    end
    # return render json: { review: review.to_json }
  end

  def edit
    if user_signed_in?
      review_life = ReviewLife.find(params[:id])

      if current_user.id == review_life.user_id

        image = params[:review_life][:image]
        if image.present?
          review_life.image = image
        end

        review_life.update(title: params[:review_life][:title], content: params[:review_life][:content])
        review_life.save

        prev_hash_tag_refs = HashTagRef.where(review_life_id: review_life.id)

        prev_hash_tag_refs.each do |ref|
          ref.delete
        end

        hashtag_str = params[:hashtag]
        hashtag_str.downcase!
        hashtag_str.delete! "\ "

        hashtags_tmp = hashtag_str.split("#")
        hashtags = []

        hashtags_tmp.each do |hashtag|
          if hashtag != "" && !hashtags.include?(hashtag)
            hashtags.push(hashtag)
            current_tag = HashTag.where(keyword: hashtag).take
            if !current_tag.present?
              current_tag = HashTag.create(keyword: hashtag)
            end
            HashTagRef.create(hash_tag_id: current_tag.id, review_life_id: review_life.id)
          end
        end
      end
    end

    redirect_to root_path
  end

  def create
    if user_signed_in?
      review_life = current_user.review_lifes.new(review_life_params)
      review_life.save

      hashtag_str = params[:hashtag]
      hashtag_str.downcase!
      hashtag_str.delete! "\ "

      hashtags_tmp = hashtag_str.split("#")
      hashtags = []

      hashtags_tmp.each do |hashtag|
        if hashtag != "" && !hashtags.include?(hashtag)
          hashtags.push(hashtag)
          current_tag = HashTag.where(keyword: hashtag).take
          if !current_tag.present?
            current_tag = HashTag.create(keyword: hashtag)
          end
          HashTagRef.create(hash_tag_id: current_tag.id, review_life_id: review_life.id)
        end
      end
    end

    redirect_to root_path
  end

  def destroy
    if user_signed_in?
      review_id = params[:id]
      review = ReviewLife.find(review_id)
      if current_user.id == review.user_id
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
    else
      redirect_to root_path
    end
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

  def submit_comment
    if user_signed_in?
      review_life_id = params[:review_life_id]
      content = params[:comment]
      CommentLife.create(review_life_id: review_life_id, user_id: current_user.id, content: content)
      return render json: { current_user: true }
    else
      return render json: { current_user: false }
    end
  end

  def submit_subcomment
    if user_signed_in?
      comment_life_id = params[:comment_life_id]
      content = params[:comment]
      SubcommentLife.create(comment_life_id: comment_life_id, user_id: current_user.id, content: content)
      return render json: { current_user: true }
    else
      return render json: { current_user: false }
    end
  end

  def delete_comment
    comment = CommentLife.find(params[:comment_id])
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
    subcomment = SubcommentLife.find(params[:subcomment_id])
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
    review_life_id = params[:id]
    if user_signed_in?
      comments = ReviewLife.find(review_life_id).comments (current_user)
    else
      comments = ReviewLife.find(review_life_id).comments
    end
    puts comments
    return render json: { comments: comments }
  end

  def scrap
    if user_signed_in?
      review_life_id = params[:id]

      current_state = ScrapLife.where(review_life_id: review_life_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_scraped: false }
      else
        ScrapLife.create(review_life_id: review_life_id, user_id: current_user.id)
        return render json: { current_user: true, has_scraped: true }
      end
    else
      return render json: { current_user: false }
    end
  end

  def upvote_comment
    if user_signed_in?
      comment_life_id = params[:id]

      current_state = UpvoteCommentLife.where(comment_life_id: comment_life_id, user_id: current_user.id).take
      if current_state.present?
        current_state.delete
        return render json: { current_user: true, has_upvoted: false }
      else
        UpvoteCommentLife.create(comment_life_id: comment_life_id, user_id: current_user.id)
        return render json: { current_user: true, has_upvoted: true }
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
