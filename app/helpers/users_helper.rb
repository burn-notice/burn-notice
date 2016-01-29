module UsersHelper
  def gravatar(user)
    image_tag "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip.downcase)}", alt: user.nickname, title: user.nickname
  end
end
