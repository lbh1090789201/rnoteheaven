#json.merge! @user.attributes

json.extract! @user, :id, :show_name, :cellphone, :username, :email

json.avatar_url @user.avatar_url
