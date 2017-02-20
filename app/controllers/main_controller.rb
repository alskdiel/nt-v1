class MainController < ApplicationController
  CARDNUMPERLOAD = 10

  def index
    @mode = "all"
    # binding pry

    render "main/index"
  end

  def get_reviews

    @reviews_new = []
    begin
      review_stamper = ReviewTimeStamper.order("created_at DESC").take(CARDNUMPERLOAD)
    rescue
      review_stamper = ReviewTimeStamper.order("created_at DESC")
    end
    review_stamper.each do |stamper|
      if stamper.review_type == 0  # house
        review = ReviewHouse.where(id: stamper.review_id).take
        if review.present?
          @reviews_new.push(review)
        end
      else                  # life
        review = ReviewLife.where(id: stamper.review_id).take
        if review.present?
          @reviews_new.push(review)
        end
      end
    end

    @reviews = {}

    @reviews[:new] = @reviews_new
    begin
      @reviews[:best] = JSON[$redis.get("main_best")][0..CARDNUMPERLOAD-1]
    rescue
    end
    @best_index = CARDNUMPERLOAD

    begin
      @reviews[:hot] = JSON[$redis.get("main_hot")][0..CARDNUMPERLOAD-1]
    rescue
    end
    @hot_index = CARDNUMPERLOAD

  end

  def get_more_new
    review_last = params[:last_review]
    time_stamper_id = review_last[:time_stamper_id]
    last_time = ReviewTimeStamper.find(time_stamper_id).created_at

    review_tmp = []

    cur_reviews = []
    begin
      cur_review_stamper = ReviewTimeStamper.where("created_at < ?", last_time).take(CARDNUMPERLOAD)
    rescue
      cur_review_stamper = ReviewTimeStamper.where("created_at < ?", last_time)
    end
    cur_review_stamper.each do |stamper|
      if stamper.review_type == 0  # house
        review = ReviewHouse.where(id: stamper.review_id).take
        if review.present?
          cur_reviews.push(review)
        end
      else                  # life
        review = ReviewLife.where(id: stamper.review_id).take
        if review.present?
          cur_reviews.push(review)
        end
      end
    end
    @reviews = cur_reviews
  end

  def get_more_hot
    index = params[:index]
    begin
      reviews_hot = JSON[$redis.get("main_hot")][index..(index + CARDNUMPERLOAD - 1)]
      hot_index = index + CARDNUMPERLOAD
      return render json: {
        reviews: reviews_hot,
        type: "hot",
        index: hot_index
      }
    rescue
    end
  end

  def get_more_best
    index = params[:index]
    begin
      reviews_best = JSON[$redis.get("main_best")][index..(index + CARDNUMPERLOAD - 1)]
      best_index = index + CARDNUMPERLOAD
      return render json: {
        reviews: reviews_best,
        type: "best",
        index: best_index
      }
    rescue
    end
  end

  def search_item
    param_arr = params[:params].split("&")
    @reviews = []
    @type = params[:type]

    if @type == "house"
      @queries = []

      param_arr.each do |param|
        @queries.push('(title LIKE "%' + param + '%" OR address LIKE "%' + param + '%")')
      end

      @query = @queries.join(" AND ");
      @reviews = ReviewHouse.where(@query)

    else @type == "life"
      isPossible = true

      hash_id_arr = []
      param_arr.each do |param|
        tag = HashTag.where(keyword: param).take
        if tag.present?
          hash_id_arr.push(tag.id)
        else
          isPossible = false
        end
      end

      if isPossible
        hash_ref_arr = []
        hash_id_arr.each do |id|
          hash_ref_arr.push(HashTagRef.where(hash_tag_id: id).pluck(:review_life_id))
        end

        toret = []
        if hash_ref_arr[0].present?

          checker = Array.new(hash_ref_arr.size)

          hash_ref_arr[0].each do |x|
            i = 0

            hash_ref_arr.each do |ref|
              if ref.include? x
                checker[i] = true
              else
                checker[i] = false
              end
              i += 1
            end

            c = true
            checker.each do |x|
              c = c && x
            end

            if c
              toret.push(x)
            end

          end

          toret.each do |review_id|
            @reviews.push(ReviewLife.find(review_id))
          end
        else
          @reviews = []
        end
      end
    end
  end

  def review_map
    render "review_map/index"
  end

  def reviews_in_bound
    # @reviews = ReviewHouse.all
    bounds = params[:bounds]
    min_lat = bounds[:ha]
    max_lat = bounds[:ga]
    min_lng = bounds[:ba]
    max_lng = bounds[:fa]
    @reviews = ReviewHouse.where("latitude >= ? AND latitude <= ? AND longtitude >= ? AND longtitude <= ?", min_lat, max_lat, min_lng, max_lng)
  end

  def notice
    @notice = Notice.paginate(:page => params[:page])
  end

  def qna
    @qnas = []
    if user_signed_in?
      @qnas = current_user.qnas.order("created_at DESC").paginate(:page => params[:page])
    end
  end

  def create_qna
    title = params[:qna][:title]
    question = params[:qna][:question]
    if user_signed_in?
      current_user.qnas.create(title: title, question: question)
    end

    redirect_to action: 'qna'
  end

  def user_signed_in
    return render json: { user_signed_in: user_signed_in? }
  end

  def link_to
    review_id = params[:id]
    url = params[:url]

    if user_signed_in?
      LinktoHitLog.create(user_id: current_user.id, review_life_id: review_id, url: url)
    else
      LinktoHitLog.create(review_life_id: review_id, url: url)
    end
    redirect_to url
  end

  def g_timestamper
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

    @reviews_all = []
    houses.each do |house|
      @reviews_all.push(house)
    end

    lives.each do |life|
      @reviews_all.push(life)
    end

    @reviews_all.sort_by! { |review| review.created_at }

    @reviews_all.each do |review|
      if review.is_house_review? # type 0
        stamper = ReviewTimeStamper.create(review_type: 0, review_id: review.id)
      else                # type 1
        stamper = ReviewTimeStamper.create(review_type: 1, review_id: review.id)
      end
      stamper.update(created_at: review.created_at)
    end

    binding pry
  end

end
