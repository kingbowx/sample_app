module UsersHelper

  def gravatar_for(user, options = { :size => 40 })
    gravatar_image_tag(user.email.downcase, :alt      => user.name,
    #gravatar_image_tag("kfengdev@gmail.com", :alt      => user.name,
                                            :class    => 'gravatar',
                                            :gravatar => options)
  end
end
