json.(item, :id, :brand, :condition,
    :original_price, :description, :sale_price,
    :trade_price, :allow_pickup, :weight,
    :size, :title, :category, :staff_pick )

json.photo_url item.photo.url(:medium)

json.user_avatar_url item.user.avatar.url(:medium)

json.username item.user.username
json.user_id item.user.id

comments ||= nil
unless comments.nil?
  json.comments(comments) do |comment|
    json.partial!("comments/comment", :comment => comment)
  end
end