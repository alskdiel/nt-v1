json.id @review.id
json.auth @auth
json.image_url @review.image_url
json.title @review.title
json.written_by @review.written_by
json.address @review.address

json.duration do
  json.start_time @review.start_time.strftime("%Y-%m")
  json.end_time @review.end_time.strftime("%Y-%m")
end

json.satisfaction do
  json.avr @review.avr_satis
  json.price @review.price_satisfaction
  json.residence @review.residence_satisfaction
  json.env @review.env_satisfaction
end

json.reviews do
  json.price @review.price_review
  json.residence @review.residence_review
  json.env @review.env_review
end

json.pros_and_cons do
  json.pros @review.pros
  json.cons @review.cons
end

json.upvote_and_scrap do
  json.has_upvoted @upvote
  json.cnt_upvotes @review.cnt_upvotes
  json.has_scraped @scrap
  json.cnt_scraps @review.cnt_scraps
end
