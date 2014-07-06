json.(comment, :id, :content, :created_at, :updated_at)

json.user_avatar_url comment.author.avatar.url(:thumb)
json.user_username comment.author.username
json.user_id comment.author.id
json.user_fname comment.author.fname