json.(item, :id, :brand, :condition,
    :original_price, :description, :sale_price,
    :trade_price, :allow_pickup, :weight,
    :size, :title, :category, :staff_pick )

comments ||= nil
unless comments.nil?
  json.comments(comments) do |comment|
    json.partial!("comments/comment", :comment => comment)
  end
end