module ReviewHousesHelper

  def self.calc_best
    reviews = ReviewHouse.all.order("created_at DESC")

    temp = []
    reviews.each do |review|
      temp.push(review: review,
                best_param: review.param_best)
    end

    temp.sort_by! { |o| o[:best_param] }.reverse!
    review_best = []
    temp.each do |o|
      review = o[:review]
      if review.is_house_review?
        review_best.push({
          is_house_review: review.is_house_review?,
          id: review.id,
          thumb_nail: review.thumb_nail,
          title: review.title,
          written_by: review.written_by,
          cnt_upvotes: review.cnt_upvotes,
          cnt_scraps: review.cnt_scraps,
          address: review.address,
          avr_satis: review.avr_satis })
      else
        review_best.push({
          is_house_review: review.is_house_review?,
          id: review.id,
          thumb_nail: review.thumb_nail,
          title: review.title,
          written_by: review.written_by,
          cnt_upvotes: review.cnt_upvotes,
          cnt_scraps: review.cnt_scraps,
          hash_tags: review.hash_tag_str })
        # review_best.push(o[:review])
      end
    end

    # $review_best_house = review_best
    $redis.set("house_best", review_best.to_json)

    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated best in house'
  end

  def self.calc_hot
    # reviews = ReviewHouse.all.order("created_at DESC")
    # review_hash_arr = []
    # reviews.each do |review|
    #   reviews_hash_arr.push({
    #     id: review.id,
    #     hit_count: review.hit_count
    #   })
    # end
    #
    # if !$redis.get("house_hot_prev")
    #   $redis.set("house_hot_prev", reviews)
    # else
    #   $redis.set("house_hot_current", reviews)
    #   reviews_prev = $redis.get("house_hot_prev")
    #   reviews_current = reviews
    #
    #
    #
    #
    # end
    #
    # temp = []
    # reviews.each do |review|
    #   temp.push(review: review,
    #             hit_count: review.hit_count)
    # end
    #
    # temp.sort_by! { |o| o[:hit_count] }.reverse!
    # review_best = []
    # temp.each do |o|
    #   review = o[:review]
    #   if review.is_house_review?
    #     review_best.push({
    #       is_house_review: review.is_house_review?,
    #       id: review.id,
    #       thumb_nail: review.thumb_nail,
    #       title: review.title,
    #       written_by: review.written_by,
    #       cnt_upvotes: review.cnt_upvotes,
    #       cnt_scraps: review.cnt_scraps,
    #       address: review.address,
    #       avr_satis: review.avr_satis })
    #   else
    #     review_best.push({
    #       is_house_review: review.is_house_review?,
    #       id: review.id,
    #       thumb_nail: review.thumb_nail,
    #       title: review.title,
    #       written_by: review.written_by,
    #       cnt_upvotes: review.cnt_upvotes,
    #       cnt_scraps: review.cnt_scraps,
    #       hash_tags: review.hash_tag_str })
    #     # review_best.push(o[:review])
    #   end
    # end

    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated hot in house'
  end
end
