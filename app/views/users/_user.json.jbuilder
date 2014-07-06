json.(user, :id, :username, :fname,
    :lname)

json.avatar_url user.avatar.url(:medium)