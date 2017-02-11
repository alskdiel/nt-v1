json.reviews do
  json.array! @reviews do |review|
    json.is_house_review review.is_house_review?
    json.id review.id
    json.thumb_nail review.thumb_nail
    json.title review.title
    json.written_by review.written_by
    json.cnt_upvotes review.cnt_upvotes
    json.cnt_scraps review.cnt_scraps

    if review.is_house_review?
      json.address review.address
      json.avr_satis review.avr_satis
    else
      json.hash_tags review.hash_tag_str
    end
  end
end
