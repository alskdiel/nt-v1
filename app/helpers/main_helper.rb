module MainHelper

  def self.calc_best
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

    reviews = []
    houses.each do |house|
      reviews.push(house)
    end
    lives.each do |life|
      reviews.push(life)
    end

    reviews.sort_by! { |review| review.created_at }.reverse!

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

    # $review_best_main = review_best
    # binding pry
    $redis.set("main_best", review_best.to_json)

    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated best in main'
  end

  def self.calc_hot
    houses = ReviewHouse.all.order("created_at DESC")
    lives = ReviewLife.all.order("created_at DESC")

    reviews = []
    houses.each do |house|
      reviews.push(house)
    end
    lives.each do |life|
      reviews.push(life)
    end

    reviews.sort_by! { |review| review.created_at }.reverse!

    current_hits = []

    reviews.each do |review|
      current_hits.push({
        id: review.id,
        hit_count: review.hit_count,
        is_house_review: review.is_house_review?
      })
    end

    prev_hits = []

    begin
      prev_hits = JSON[$redis.get("prev_hit_review_main")]
    rescue
    end

    if prev_hits.present?
      temp = []

      prev_hits.each do |prev_hit|

        if prev_hit["is_house_review"]
          r = ReviewHouse.find(prev_hit["id"])
        else
          r = ReviewLife.find(prev_hit["id"])
        end

        c = r.hit_count
        p = prev_hit["hit_count"]
        diff = c - p
        temp.push(
          review: r,
          diff: diff
        )
      end

      temp.sort_by! { |o| o[:diff] }.reverse!
      review_hot = []
      temp.each do |o|
        review = o[:review]
        if review.is_house_review?
          review_hot.push({
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
          review_hot.push({
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
      $redis.set("main_hot", review_hot.to_json)
    end

    $redis.set("prev_hit_review_main", current_hits.to_json)
    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated hot in main'
  end
end
