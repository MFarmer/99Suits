json.(user, :id, :username, :fname,
    :lname, :bio)

json.avatar_url user.avatar.url(:medium)