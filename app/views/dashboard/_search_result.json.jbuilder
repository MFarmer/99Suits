json.(result, :id, :content, :searchable_id, :searchable_type )
if result.searchable_type == "Item"
  json.image_url result.searchable.photo.url(:thumb)
  json.title result.searchable.title
  json.sale_price result.searchable.sale_price
  json.trade_price result.searchable.trade_price
else
  json.image_url result.searchable.avatar.url(:thumb)
  json.header_text "#{result.searchable.fname} #{result.searchable.lname}"
  json.subtitle_text "@#{result.searchable.username}"
  json.bio result.searchable.bio
end