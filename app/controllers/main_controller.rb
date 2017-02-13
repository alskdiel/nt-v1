class MainController < ApplicationController

  def index
    @mode = "all"

    render "main/index"
  end

  def get_reviews
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

    @reviews = []

    i = 0
    j = 0

    begin
      while true
        if houses[i].created_at > lives[j].created_at
          @reviews.push(houses[i])
          i += 1
        else
          @reviews.push(lives[j])
          j += 1
        end
      end
    rescue
      if houses[i].present?
        @reviews.push(houses[i])
      else
        @reviews.push(lives[j])
      end
    end

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

  def user_signed_in
    return render json: { user_signed_in: user_signed_in? }
  end
end
