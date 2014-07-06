json.(feedback, :id, :order_id, :content, :rating, :created_at)

json.user_avatar_url feedback.order.buyer.avatar.url(:medium)
json.reviewer_id feedback.order.buyer.id
json.user_fname feedback.order.buyer.fname
json.user_lname feedback.order.buyer.lname