json.id @review.id
json.image_url @review.image_url
json.title @review.title
json.written_by @review.written_by
json.hash_tags @review.hash_tag_str
json.content @review.content

json.upvote_and_scrap do
  json.has_upvoted @upvote
  json.cnt_upvotes @review.cnt_upvotes
  json.has_scraped @scrap
  json.cnt_scraps @review.cnt_scraps
end
