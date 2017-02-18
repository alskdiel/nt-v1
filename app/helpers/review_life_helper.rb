module ReviewLifeHelper

  def self.calc_best
    reviews = ReviewLife.all.order("created_at DESC")

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

    # $review_best_life = review_best
    $redis.set("life_best", review_best.to_json)

    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated best in life'
  end

  def self.calc_hot
    puts Time.now.strftime("%Y-%m-%d %H:%M")+' // calculated hot in life'
  end
end
