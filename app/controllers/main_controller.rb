class MainController < ApplicationController

  def index
    @mode = "all"

    render "main/index"
  end

  def get_reviews
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

    @reviews = []
    houses.each do |house|
      @reviews.push(house)
    end
    lives.each do |life|
      @reviews.push(life)
    end

    @reviews.sort_by! { |review| review.created_at }.reverse!

  end


  def search_item
    param_arr = params[:params].split("&")
    @reviews = []

    if params[:type] == "house"
      @queries = []

      param_arr.each do |param|
        @queries.push('(title LIKE "%' + param + '%" OR address LIKE "%' + param + '%")')
      end

      @query = @queries.join(" AND ");
      @reviews = ReviewHouse.where(@query)

    else params[:type] == "life"
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


  def create_sample_data
    phone_nums = [34330015,51440933,89670512,99927727,43009833,91815091,99839996,51748619,94328639,47313861,71285037,39060048,55140769,39590126,26636835,28183494,42424940,51093316,43986859,92219473,75524892,51748619,75745233,34889843,47592398,33777537,91147921,91189276,74401535]
    i = 1;

    phone_nums.each do |phone_num|
      email = phone_num.to_s + "@findahouse.co.kr"
      password = phone_num
      user = User.new(email: email, password: password, password_confirmation: password)
      user.skip_confirmation!
      user.save

      nickname = "내집탐방" + i.to_s
      UserInfo.create(user_id: user.id, nickname: nickname)
      i += 1
    end

    @mode = "all"

    render "main/index"
  end

end
