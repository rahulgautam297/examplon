module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}
    &r=g&d=mm"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
            
  def correct_user_task_form?
    current_user== User.find(params[:id])
  end 
end
