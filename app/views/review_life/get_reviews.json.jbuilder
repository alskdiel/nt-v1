# json.review_best do
#   json.array! @reviews[:best] do |review|
#     json.is_house_review review.is_house_review?
#     json.id review.id
#     json.thumb_nail review.thumb_nail
#     json.title review.title
#     json.hash_tags review.hash_tag_str
#     json.written_by review.written_by
#     json.cnt_upvotes review.cnt_upvotes
#     json.cnt_scraps review.cnt_scraps
#   end
# end

json.review_best @reviews[:best]
json.review_new do
  json.array! @reviews[:new] do |review|
    json.is_house_review review.is_house_review?
    json.id review.id
    json.thumb_nail review.thumb_nail
    json.title review.title
    json.hash_tags review.hash_tag_str
    json.written_by review.written_by
    json.cnt_upvotes review.cnt_upvotes
    json.cnt_scraps review.cnt_scraps
  end
end
